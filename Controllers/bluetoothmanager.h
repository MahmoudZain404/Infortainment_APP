#ifndef BLUETOOTHMANAGER_H
#define BLUETOOTHMANAGER_H

#include <QObject>
#include <QProcess>
#include <QStringList>

class BluetoothManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList deviceList READ deviceList NOTIFY deviceListChanged)

public:
    explicit BluetoothManager(QObject *parent = nullptr);
    Q_INVOKABLE void scanDevices();
    Q_INVOKABLE void pairDevice(QString address);
    Q_INVOKABLE void pairAndStreamAudio(const QString &deviceAddress, const QString &deviceName , const QString &command);
    QStringList deviceList() const;

signals:
    void deviceListChanged();
    void pairingFinished(bool success);

private slots:
    void processScanOutput();
    void processPairingOutput();

private:
    QProcess *bluetoothProcess;
    QStringList m_deviceList;
};

#endif // BLUETOOTHMANAGER_H
