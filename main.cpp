#include "Controllers/bluetoothmanager.h"
#include "Controllers/system.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include <QQmlContext>
#include <QQuickWindow>


int main(int argc, char *argv[])
{
    // Set OpenGL context sharing
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    // Set OpenGL as the rendering backend
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGLRhi);


    // initialize QtWebView
  //  QtWebView::initialize();

    // En
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    class system m_systemHandler;

    QGuiApplication app(argc, argv);

    qmlRegisterType<BluetoothManager>("mybluetoothclass", 1, 0, "BluetoothManager");


    QQmlApplicationEngine engine;

    QQmlContext * context ( engine.rootContext() );

    context->setContextProperty("systemHandler", &m_systemHandler );

    const QUrl url(QStringLiteral("qrc:/Infotainment_App/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
