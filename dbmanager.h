#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariantList>

class DBManager : public QObject {
    Q_OBJECT
public:
    explicit DBManager(QObject *parent = nullptr);

    Q_INVOKABLE bool registerUser(const QString &username, const QString &password);
    Q_INVOKABLE bool loginUser(const QString &username, const QString &password);

    Q_INVOKABLE bool addTransaction(const QString &username, const QString &type, double amount);
    Q_INVOKABLE QVariantList getTransactions(const QString &username);
    Q_INVOKABLE double getBalance(const QString &username);

    Q_INVOKABLE bool changePassword(const QString &username, const QString &oldPass, const QString &newPass);
    Q_INVOKABLE bool deleteUser(const QString &username, const QString &password);

private:
    QSqlDatabase m_db;
    QString hashPassword(const QString &pass);
    bool userExists(const QString &username);
    bool verifyPassword(const QString &username, const QString &pass);
};

#endif // DBMANAGER_H