import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtMultimedia 6.5
import mybluetoothclass 1.0

Rectangle
{
    id: leftScreen
    anchors
    {
        top: parent.top
        bottom: bottomBar.top
        right: rightScreen.left
        left: parent.left
    }

    color: "black"

    ApplicationWindow {
        visible: rearCameraState ?  true : false
        height: rightScreen.height * 0.60
        width: rightScreen.width
        flags: Qt.SplashScreen
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            Camera {
                id: camera
            }

            CaptureSession {
                camera: camera
                videoOutput: cameraOutput

            }

            VideoOutput {
                id: cameraOutput
                anchors.fill: parent
            }
            Component.onCompleted: {

            }
        }
    }

    Image {
        id: carLock
        anchors{
            left: parent.left
            top: parent.top
            margins: 20
        }
        width: parent.width / 18
        fillMode: Image.PreserveAspectFit
        source: (systemHandler.carLock ? "../assets/carLocked.png" : "../assets/carUnlocked.png")
        MouseArea{
            anchors.fill: parent
            onClicked: ( systemHandler.setcarLock( !systemHandler.carLock ) )
        }
    }

    Text {
        id: dataTime
        anchors {
            left: carLock.right
            leftMargin: 20
            bottom: carLock.bottom
        }
        font.pixelSize: 18
        font.bold: true
        color: "white"
        text: systemHandler.currentTime
    }

    Text {
        id: outsideTemp
        anchors {
            left: dataTime.right
            leftMargin: 20
            bottom: dataTime.bottom
        }
        font.pixelSize: 18
        font.bold: true
        color: "white"
        text: systemHandler.outSideTemp + "°C"
    }

    Image {
        id: driverIcon
        anchors{
            left: outsideTemp.right
            bottom: outsideTemp.bottom
            leftMargin: 20
        }
        width: parent.width / 18
        fillMode: Image.PreserveAspectFit
        source: "../assets/driver.png"
    }

    Text {
        id: driverName
        anchors {
            left: driverIcon.right
            leftMargin: 10
            bottom: driverIcon.bottom
        }
        font.pixelSize: 18
        font.bold: true
        color: "white"
        text: systemHandler.driverName
    }
    property bool rearCameraState: false

    Image {
        id: rearCamera
        anchors{
            left: driverName.right
            bottom: driverName.bottom
            leftMargin: 20
        }
        width: parent.width / 18
        fillMode: Image.PreserveAspectFit
        source: rearCameraState ? "../assets/cameraOn.png" : "../assets/cameraOff.png"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (rearCameraState) {
                    camera.stop();
                } else {
                    camera.start();
                }

                rearCameraState = !rearCameraState;
            }
        }
    }
    property bool bluetoothState: false



    Image {
        id: bluetoothIcon
        anchors{
            left: rearCamera.right
            bottom: rearCamera.bottom
            leftMargin: 20
        }
        width: parent.width / 18
        fillMode: Image.PreserveAspectFit
        source: bluetoothState ? "../assets/bluetoothOn.png" : "../assets/bluetoothOff.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (bluetoothState) { //bluetoothState  bottomBarData.playPauseState
                    bluetoothManager.pairAndStreamAudio("9C:A5:13:18:E7:AA", "SHADOW's Galaxy M11", "disconnect")
                } else {
                    bluetoothManager.pairAndStreamAudio("9C:A5:13:18:E7:AA", "SHADOW's Galaxy M11", "connect")
                }

                bluetoothState = !bluetoothState;
            }
        }
    }



    // MediaPlayer {
    //     id: videoPlayerAudio
    //     source: "../assets/Car_Render_mp4.mp4" // Change to absolute path if needed
    //     audioOutput: audioOutput
    //     loops: MediaPlayer.Infinite  // Loop audio
    // }
    // AudioOutput{
    //     id: audioOutput
    //     volume: 1.0
    // }
    // Component.onCompleted: {
    //     //mediaPlayer.setSource("video.mp4");  // Ensure file exists
    //     console.log("Setting source to video.mp4...");
    //     videoPlayerAudio.play();
    // }
    // Image
    // {
    //     id: carRender
    //     anchors.centerIn: parent
    //     width: parent.width *0.95
    //     fillMode: Image.TileHorizontally
    //     source: "../assets/car_render_white.jpeg"
    // }



}







// MediaPlayer
// {
//     id: mediaPlayer
//     source: "../assets/Car_Render_mp4.mp4"
//     videoOutput: videoOutput
//     audioOutput: AudioOutput {
//         id: audio
//         muted: playbackController.muted
//         volume: playbackController.volume
//     }

//     VideoOutput
//     {
//         id: videoOutput
//         anchors.fill: parent
//         visible: mediaPlayer.mediaStatus > 0

//         TapHandler
//         {
//             onDoubleTapped:
//             {
//                 root.fullScreen ?  root.showNormal() : root.showFullScreen()
//                 root.fullScreen = !root.fullScreen
//             }
//         }
//     }
// }
