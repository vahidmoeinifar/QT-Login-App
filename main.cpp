#include <QAbstractTableModel>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    qmlRegisterUncreatableType<QAbstractTableModel>("QAbstractTableModel", 1, 0, "QAbstractTableModel", "uncreatable");
    qmlRegisterUncreatableType<QAbstractListModel>("QAbstractListModel", 1, 0, "QAbstractListModel", "uncreatable");

    return app.exec();
}
