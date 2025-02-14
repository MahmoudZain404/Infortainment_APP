#ifndef SYSTEM_H
#define SYSTEM_H

#include <QObject>
#include <QTimer>

class system : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool carLock READ carLock WRITE setcarLock NOTIFY carLockChanged )
    Q_PROPERTY(QString driverName READ driverName WRITE setdriverName NOTIFY driverNameChanged )
    Q_PROPERTY(int outSideTemp READ outSideTemp WRITE setoutSideTemp NOTIFY outSideTempChanged )
    Q_PROPERTY(QString currentTime READ currentTime WRITE setCurrentTime NOTIFY currentTimeChanged )

public:
    explicit system(QObject *parent = nullptr);

    bool carLock() const;

    QString driverName() const;

    int outSideTemp() const;

    QString currentTime() const;

public slots:
    void setcarLock(bool newCarLock);
    void setdriverName(const QString &newDriverName);
    void setoutSideTemp(int newOutSideTemp);
    void setCurrentTime(const QString &newCurrentTime);


    void TimeTimerTimeout();


signals:
    void carLockChanged();
    void driverNameChanged();

    void outSideTempChanged();

    void currentTimeChanged();

private:
    bool m_carLock;
    QString m_driverName;
    int m_outSideTemp;
    QString m_currentTime;
    QTimer * m_TimeTimer;
};

#endif // SYSTEM_H
