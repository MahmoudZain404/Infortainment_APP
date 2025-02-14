#ifndef MAPCONTROLLER_H
#define MAPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QJsonDocument>
#include <QJsonObject>

class MapController : public QObject
{
    Q_OBJECT
public:
    explicit MapController(QObject *parent = nullptr);

    Q_INVOKABLE void getRoute(QString start, QString end);
    Q_INVOKABLE void geocodeAddress(QString address);

signals:
    void routeReceived(QString route);
    void geocodeReceived(double lat, double lon);

private slots:
    void onRouteReplyFinished();
    void onGeocodeReplyFinished();

private:
    QNetworkAccessManager *m_networkManager;
};


#endif // MAPCONTROLLER_H
