#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <Controllers/system.h>
#include <QQmlContext>
#include <QProcess>
#include <QObject>
#include <QtWebView/QtWebView>
#include <QtVirtualKeyboard>
//#include <QtQml>

// class BluetoothManager : public QObject {
//     Q_OBJECT

// public:
//     explicit BluetoothManager(QObject *parent = nullptr) : QObject(parent) {}

//     Q_INVOKABLE void pairAndStreamAudio(const QString &deviceAddress, const QString &deviceName , const QString &command)
//     {
//         qDebug() << "Starting pairing and audio stream...";

//         // Step 1: Pair the device via bluetoothctl (replace with actual MAC address)
//         QProcess *bluetoothProcess = new QProcess(this);
//         bluetoothProcess->start("bluetoothctl", QStringList() << command << deviceAddress);

//         connect(bluetoothProcess, &QProcess::finished, this, [=]() {
//             qDebug() << "Bluetooth device paired successfully.";

//             // Step 2: After pairing, route audio to the Bluetooth device via PulseAudio
//             QProcess *pulseAudioProcess = new QProcess(this);
//             pulseAudioProcess->start("pactl", QStringList() << "set-default-sink" << deviceName);

//             connect(pulseAudioProcess, &QProcess::finished, this, [](){
//                 qDebug() << "Audio routed to Bluetooth device.";
//             });
//         });
//     }
// };


//#include "main.moc"
#include "bluetoothmanager.h"

int main(int argc, char *argv[])
{
    // initialize QtWebView
    QtWebView::initialize();

    // Enable Virtual Keyboard
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    //BluetoothManager bluetoothManager;


    QQmlApplicationEngine engine;

    qmlRegisterType<BluetoothManager>("mybluetoothclass", 1, 0, "BluetoothManager");

        //engine.rootContext()->setContextProperty("bluetoothManager", &bluetoothManager);
       // engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

        class system m_systemHandler;

        QQmlContext * context ( engine.rootContext() );
        context->setContextProperty("systemHandler", &m_systemHandler );

    engine.loadFromModule("Infotainment_App", "Main");

    return app.exec();
}
