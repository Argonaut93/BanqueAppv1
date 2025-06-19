#include "dbmanager.h"
#include <QSqlError>
#include <QCryptographicHash>
#include <QDebug>
#include <iostream>

DBManager::DBManager(QObject *parent) : QObject(parent) {
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("banque.db");
    if (!m_db.open()) {
        qDebug() << "Erreur DB:" << m_db.lastError().text();
        return;
    }

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT)");
    query.exec("CREATE TABLE IF NOT EXISTS transactions (id INTEGER PRIMARY KEY, username TEXT, type TEXT, amount REAL, date TEXT)");
}

QString DBManager::hashPassword(const QString &pass) {
    QByteArray hash = QCryptographicHash::hash(pass.toUtf8(), QCryptographicHash::Sha256);
    return QString(hash.toHex());
}

bool DBManager::userExists(const QString &username) {
    QSqlQuery query;
    query.prepare("SELECT 1 FROM users WHERE username = ?");
    query.addBindValue(username);//permet de lutter contre l'injection SQL
    query.exec();
    return query.next();
}

bool DBManager::registerUser(const QString &username, const QString &password) {
    qDebug()<<username<<"et"<<password;

    if (userExists(username)) return false;
    QSqlQuery query;
    query.prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    query.addBindValue("username");
    query.addBindValue(hashPassword(password));
    return query.exec();
}

bool DBManager::verifyPassword(const QString &username, const QString &pass) {
    QSqlQuery query;
    query.prepare("SELECT password FROM users WHERE username = ?");
    query.addBindValue(username);
    query.exec();
    if(!query.exec()){
        qDebug()<<"Erreur de la requete";
        return false;
    }
    if (query.next()) {// a faire av de tenter de lire une value
        qDebug()<<username<<"&"<<query.value(0).toString();
        QString storedHash = query.value(0).toString();
        //return storedHash == hashPassword(pass);chgt here
        return hashPassword(storedHash) == hashPassword(pass);// a remettre comme avant car la cest faux

    }
    return false;
}

bool DBManager::loginUser(const QString &username, const QString &password) {
    return verifyPassword(username, password);
}

bool DBManager::addTransaction(const QString &username, const QString &type, double amount) {
    QSqlQuery query;
    query.prepare("INSERT INTO transactions (username, type, amount, date) VALUES (?, ?, ?, datetime('now'))");
    query.addBindValue(username);
    query.addBindValue(type);
    query.addBindValue(amount);
    return query.exec();
}

QVariantList DBManager::getTransactions(const QString &username) {
    QVariantList list;
    QSqlQuery query;
    query.prepare("SELECT date, type, amount FROM transactions WHERE username = ? ORDER BY date DESC");
    query.addBindValue(username);
    query.exec();
    while (query.next()) {
        QString line = QString("%1 - %2: %3 €")
                       .arg(query.value(0).toString())
                       .arg(query.value(1).toString())
                       .arg(query.value(2).toDouble());
        list << line;
    }
    return list;
}

double DBManager::getBalance(const QString &username) {
    QSqlQuery query;
    query.prepare("SELECT type, amount FROM transactions WHERE username = ?");
    query.addBindValue(username);
    query.exec();
    double bal = 0.0;
    while (query.next()) {
        QString type = query.value(0).toString();
        double amt = query.value(1).toDouble();
        bal += (type == "depot") ? amt : -amt;
    }
    return bal;
}

bool DBManager::changePassword(const QString &username, const QString &oldPass, const QString &newPass) {
    if (!verifyPassword(username, oldPass)) return false;
    QSqlQuery query;
    query.prepare("UPDATE users SET password = ? WHERE username = ?");
    query.addBindValue(hashPassword(newPass));
    query.addBindValue(username);
    return query.exec();
}

bool DBManager::deleteUser(const QString &username, const QString &password) {
    if (!verifyPassword(username, password)) return false;
    QSqlQuery query;
    query.prepare("DELETE FROM transactions WHERE username = ?");
    query.addBindValue(username);
    query.exec();
    query.prepare("DELETE FROM users WHERE username = ?");
    query.addBindValue(username);
    return query.exec();
}
