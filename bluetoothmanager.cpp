#include "bluetoothmanager.h"
#include <QDebug>

BluetoothManager::BluetoothManager(QObject *parent) : QObject(parent) {
    bluetoothProcess = new QProcess(this);
    connect(bluetoothProcess, &QProcess::readyReadStandardOutput, this, &BluetoothManager::processScanOutput);
}

void BluetoothManager::scanDevices() {
    m_deviceList.clear();
    emit deviceListChanged();

    bluetoothProcess->start("bluetoothctl", QStringList() << "devices");
    qDebug() << "Scanning for Bluetooth devices...";
}

void BluetoothManager::processScanOutput() {
    while (bluetoothProcess->canReadLine()) {
        QString line = bluetoothProcess->readLine().trimmed();
        if (line.contains("Device")) {
            QStringList parts = line.split(" ");
            if (parts.size() >= 3) {
                QString address = parts[1];
                QString name = parts.mid(2).join(" ");
                QString deviceInfo = name + " - " + address;

                if (!m_deviceList.contains(deviceInfo)) {
                    m_deviceList.append(deviceInfo);
                    emit deviceListChanged();
                }
            }
        }
    }
}

void BluetoothManager::pairDevice(QString address) {
    QProcess *pairingProcess = new QProcess(this);
    connect(pairingProcess, &QProcess::readyReadStandardOutput, this, &BluetoothManager::processPairingOutput);
    pairingProcess->start("bluetoothctl", QStringList() << "pair" << address);
}

void BluetoothManager::processPairingOutput() {
    QString output = bluetoothProcess->readAllStandardOutput();
    qDebug() << "Pairing Output:" << output;

    if (output.contains("Pairing successful")) {
        emit pairingFinished(true);
    } else if (output.contains("Failed")) {
        emit pairingFinished(false);
    }
}

QStringList BluetoothManager::deviceList() const {
    return m_deviceList;
}

void BluetoothManager::pairAndStreamAudio(const QString &deviceAddress, const QString &deviceName , const QString &command){

    qDebug() << "Starting pairing and audio stream...";

    // Step 1: Pair the device via bluetoothctl (replace with actual MAC address)
    bluetoothProcess->start("bluetoothctl", QStringList() << command << deviceAddress);

    connect(bluetoothProcess, &QProcess::finished, this, [=]() {
        qDebug() << "Bluetooth device paired successfully.";

        // Step 2: After pairing, route audio to the Bluetooth device via PulseAudio
        QProcess *pulseAudioProcess = new QProcess(this);
        pulseAudioProcess->start("pactl", QStringList() << "set-default-sink" << deviceName);

        connect(pulseAudioProcess, &QProcess::finished, this, [](){
            qDebug() << "Audio routed to Bluetooth device.";
        });
    });


}

