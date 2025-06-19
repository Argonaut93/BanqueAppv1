#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "dbmanager.h"

/*pb:1-n'arrive  pas a importer  le module contenant le bouton personalisé
     2-ajout des boutons pour faire l'historique, les virements,
     3-ajout des numéros de cartes bancaires
     4-comment recupérer la valeur entrer dans la page amount?
*/



int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    DBManager db;
    engine.rootContext()->setContextProperty("dbManager", &db);

    const QUrl url(QStringLiteral("qrc:/MainView.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
