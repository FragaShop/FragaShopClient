#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QIcon>
#include <QFontDatabase>
#include <QLocale>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("ffraggahit");
    app.setOrganizationDomain("ffraggahit.tech");
    app.setApplicationName("FragaShop");
    app.setApplicationVersion("0.1.0");
    app.setWindowIcon(QIcon(":/images/icons/app/appIcon.png")); // svg

    QFontDatabase::addApplicationFont(":/fonts/didot/didot-italic.ttf");
    QFontDatabase::addApplicationFont(":/fonts/code-new-roman/code-new-roman.otf");

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "FragaShop_" + QLocale(locale).name();
        if (translator.load(":/translations/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/FragaShop/src/ui/qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
