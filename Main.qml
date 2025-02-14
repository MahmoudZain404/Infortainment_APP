import QtQuick
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtMultimedia 6.8
import mybluetoothclass 1.0
import "ui/BottomBar"
import "ui/RightScreen"
import "ui/LiftScreen"

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("SHADOW404_Infotainment")

    // Loader {
    //     id: bottombardata
    //     source: "ui/BottomBar/Bottom_Bar.qml"
    // }




    Lift_Screen{
        id: liftScreen

        MediaPlayer {
            id: mediaPlayerVideo
            source: "ui/assets/Car_Render_mp4.mp4"  // Change this to your video path
            videoOutput: leftvideoOutput
            loops: MediaPlayer.Infinite
            //onPlaybackStateChanged: console.log("🔹 Playback State Changed:", playbackState)
            //onErrorOccurred: console.log("❌ Error:", error, " - ", errorString)
        }
        VideoOutput {
            id: leftvideoOutput
            anchors {
                bottom: parent.bottom
            }
            width: parent.width
        }
        // Auto-play and start looping when the application starts
        Component.onCompleted: {
            console.log("▶ Attempting to play video...");
            mediaPlayerVideo.play();
            console.log("▶ Auto-playing video on loop...");
        }
    }

    Right_Screen{
        id: rightScreen
    }

    Bottom_Bar{
        id: bottomBar
    }
    property bool driveButtonState: false
    property bool reverseButtonState: false
    property bool parkButtonState: false
    property int currentBackground: 0

    Rectangle {
        id: carSettingsWindow
        visible: bottomBar.carsettings ? true : false
        anchors.centerIn: parent
        width: parent.width * 0.80
        height: 500
        color: "lightgray"
        radius: 10
        ListModel {
            id: backgroundList
            ListElement { url: "ui/assets/wallpeper6.jpg" }
            ListElement { url: "ui/assets/wallpeper1.jpg" }
            ListElement { url: "ui/assets/wallpeper2.jpg" }
            ListElement { url: "ui/assets/wallpeper3.jpg" }
            ListElement { url: "ui/assets/wallpeper4.jpg" }
            ListElement { url: "ui/assets/wallpeper5.jpg" }
            ListElement { url: "ui/assets/wallpeper7.jpg" }
        }

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: backgroundList.get(currentBackground).url
            //fillMode: Image.stratch
        }


        Column {
            id: gearSelect

            anchors {
                left: parent.left
                margins: 5
                verticalCenter: parent.verticalCenter
            }
            width: parent.width * 0.10
            spacing: 5


            Image {
                id: driveGear
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: driveButtonState ? "ui/assets/DriveOn.png" : "ui/assets/DriveOff.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        driveButtonState = !driveButtonState
                        reverseButtonState = false
                        parkButtonState = false
                    }
                }
            }

            Image {
                id: reverseGear
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: reverseButtonState ? "ui/assets/ReverseOn.png" : "ui/assets/ReverseOff.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        reverseButtonState = !reverseButtonState
                        driveButtonState = false
                        parkButtonState = false
                    }
                }
            }

            Image {
                id: parkBreak
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: parkButtonState ? "ui/assets/ParkOn.png" : "ui/assets/ParkOff.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parkButtonState = !parkButtonState
                        driveButtonState = false
                        reverseButtonState = false
                    }
                }
            }
            Image {
                id: backgroundChange
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: "ui/assets/slideshow.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentBackground = (currentBackground + 1) % 7;
                        backgroundImage.source = backgroundList.get(currentBackground).url
                    }
                }
            }
        }

        BluetoothManager {
            id: bluetoothManager
            onPairingFinished: (success) => {
                if (success) {
                    console.log("Device paired successfully!");
                } else {
                    console.log("Pairing failed.");
                }
            }
        }

        Column {
            id: bluetoothDeviceSelect
            anchors {
                right: parent.right
                rightMargin: 120
                verticalCenter: parent.verticalCenter
            }

            spacing: 10

            Button {
                text: "Scan for Devices"
                contentItem: Text {
                       text: parent.text
                       color: "black"  // Change text color
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                   }
                background: Rectangle {
                        color: "white"  // Change button color
                        radius: 8  // Optional: Rounded corners
                    }
                onClicked: bluetoothManager.scanDevices()
            }

            ListView {
                id: bluetoothlist
                width: parent.width
                height: 300
                model: bluetoothManager.deviceList

                delegate: Item {
                    width: parent.width
                    height: 50

                    Row {
                        spacing: 20

                        Text {
                            text: modelData.split(" - ")[0]
                            width: 130
                            font.pixelSize: 13
                            font.bold: true
                            }
                        Button {
                            text: "Pair"
                            contentItem: Text {
                                   text: parent.text
                                   color: "black"  // Change text color
                                   font.bold: true
                                   horizontalAlignment: Text.AlignHCenter
                                   verticalAlignment: Text.AlignVCenter
                               }
                            background: Rectangle {
                                    color: "white"  // Change button color
                                    radius: 8  // Optional: Rounded corners
                                }
                            onClicked: {
                                let address = modelData.split(" - ")[1];
                                bluetoothManager.pairDevice(address);
                            }
                        }
                    }
                }
            }
        }
    }

}
