import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtMultimedia 6.5
import QtLocation 6.8
import QtWebView
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings


Rectangle {
    id: rightScreen
    anchors {
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }
    width: parent.width * 0.60

    WebView {
        id: webView
        anchors.fill: parent
        url: "https://www.google.com/maps"
    }

    InputPanel {
        id: virtualKeyboard
        z: 89
        y: 50
        x: 0
        width: parent.width

        anchors.centerIn: parent
        visible: Qt.inputMethod.visible
    }
}










// MapView {
//         id: view
//         anchors.fill: parent
//         map.plugin: Plugin { name: "osm" }
//         map.zoomLevel: 4
//         map.center: QtPositioning.coordinate(30.0444, 31.2357) //Cairo-Egypt
//     }

//     property variant unfinishedItem: undefined
//     property bool autoFadeIn: false
//     property variant referenceSurface: QtLocation.ReferenceSurface.Map
//     signal showMainMenu(variant coordinate)
