#include "system.h"
#include <QDateTime>
#include <QDebug>

system::system(QObject *parent)
    : QObject{parent}
    , m_carLock(true)
    , m_outSideTemp(21)
    , m_driverName("Mahmoud Zain")
    //, m_currentTime("12:00 am")
{
    m_TimeTimer = new QTimer(this);
    m_TimeTimer->setInterval(500);
    m_TimeTimer->setSingleShot(true);
    connect( m_TimeTimer, &QTimer::timeout, this, &system::TimeTimerTimeout );
    TimeTimerTimeout();
}

bool system::carLock() const
{
    return m_carLock;
}

void system::setcarLock(bool newCarLock)
{
    if (m_carLock == newCarLock)
        return;
    m_carLock = newCarLock;
    emit carLockChanged();
}

QString system::driverName() const
{
    return m_driverName;
}

void system::setdriverName(const QString &newDriverName)
{
    if (m_driverName == newDriverName)
        return;
    m_driverName = newDriverName;
    emit driverNameChanged();
}

int system::outSideTemp() const
{
    return m_outSideTemp;
}

void system::setoutSideTemp(int newOutSideTemp)
{
    if (m_outSideTemp == newOutSideTemp)
        return;
    m_outSideTemp = newOutSideTemp;
    emit outSideTempChanged();
}

QString system::currentTime() const
{
    return m_currentTime;
}

void system::setCurrentTime(const QString &newCurrentTime)
{
    if (m_currentTime == newCurrentTime)
        return;
    m_currentTime = newCurrentTime;
    emit currentTimeChanged();
}

void system::TimeTimerTimeout()
{
    QDateTime dateTime;
    QString Current_Time = dateTime.currentDateTime().toString("h:mm ap");
    setCurrentTime(Current_Time);
    //qDebug() << CurrentTime;
    m_TimeTimer->start();
}
