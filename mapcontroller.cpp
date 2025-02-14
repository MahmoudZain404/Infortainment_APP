#include "mapcontroller.h"0.
#include <QDebug>

MapController::MapController(QObject *parent) : QObject(parent)
{
    m_networkManager = new QNetworkAccessManager(this);
}

void MapController::getRoute(QString start, QString end)
{
    // Example using GraphHopper API for routing
    QString url = QString("https://graphhopper.com/api/1/route?point=%1&point=%2&vehicle=car&key=YOUR_API_KEY")
                      .arg(start).arg(end);
    QNetworkRequest request(QUrl(url));
    QNetworkReply *reply = m_networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, &MapController::onRouteReplyFinished);
}

void MapController::geocodeAddress(QString address)
{
    // Example using Nominatim (OpenStreetMap) for geocoding
    QString url = QString("https://nominatim.openstreetmap.org/search?format=json&q=%1").arg(address);
    QNetworkRequest request(QUrl(url));
    QNetworkReply *reply = m_networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, &MapController::onGeocodeReplyFinished);
}

void MapController::onRouteReplyFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(responseData);
        QJsonObject jsonObj = jsonDoc.object();
        // Parse route data here
        QString route = "Parsed route data"; // Replace with actual parsing logic
        emit routeReceived(route);
    } else {
        qDebug() << "Error fetching route:" << reply->errorString();
    }
    reply->deleteLater();
}

void MapController::onGeocodeReplyFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(responseData);
        QJsonArray jsonArray = jsonDoc.array();
        if (!jsonArray.isEmpty()) {
            QJsonObject jsonObj = jsonArray[0].toObject();
            double lat = jsonObj["lat"].toDouble();
            double lon = jsonObj["lon"].toDouble();
            emit geocodeReceived(lat, lon);
        }
    } else {
        qDebug() << "Error fetching geocode data:" << reply->errorString();
    }
    reply->deleteLater();
}
