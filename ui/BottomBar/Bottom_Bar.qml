import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 6.5

Rectangle {

    id: bottomBar
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    color: "black"
    height: parent.height / 12

    // Rectangle for layout and styling
    Rectangle {
        id: volumeControl
        anchors{
            right: parent.right
        }
        width: parent.width * 0.15
        height: parent.height * 85
        color: "black"

        // Volume Slider
        Slider {
            id: volumeSlider
            width: parent.width * 0.40
            height: 30
            anchors
            {
                right: parent.right
                margins: 10
            }

            from: 0
            to: 100
            value: 50 // Default volume level (50%)

            // Connecting the value of the slider to the media player's volume
            onValueChanged: {
               // mediaPlayer.volume = value / 100;
                musicPlayerAudioOutput.volume = value / 100;
                radioPlayerAudioOutput.volume = value / 100;
            }

            // Customizing the handle of the slider
            handle: Rectangle {
                width: 20
                height: 20
                color: "red"
                radius: 10
                // Update position of handle as per slider value
                x: volumeSlider.width * (volumeSlider.value / 100) - width / 2
                anchors.verticalCenter: parent.verticalCenter
            }

            // Label to show current volume
            Text {
                text: Math.round(volumeSlider.value) + "%"
                anchors.top: volumeSlider.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 15
                font.bold: true
                color: "red"
            }

        }
        Image {
            id: speaker
            anchors {
                left: volumeControl.left
                leftMargin: 50
                topMargin: 20
            }
            width: volumeControl.width * 0.17
            height: volumeControl.width * 0.17
            source: Math.round(volumeSlider.value) === 0 ? "../assets/volume-mute.png" : "../assets/volume-up.png"
        }
    }

    property bool carsettings: false

    Image {
        id: carSettingsIcon
        anchors{
            left: parent.left
            leftMargin: 30
            verticalCenter: parent.verticalCenter
        }
        height: parent.height * 0.85
        fillMode: Image.PreserveAspectFit
        source: "../assets/Car_settings_ic.png"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                carsettings = !carsettings
            }
        }
    }

    MediaPlayer {
           id: radioPlayer
           audioOutput: radioPlayerAudioOutput
       }

    AudioOutput {
        id: radioPlayerAudioOutput
        volume: volumeSlider.value
    }

    ListModel {
        id: stationList
        ListElement { name: "BBC World Service"; url: "http://stream.live.vc.bbcmedia.co.uk/bbc_world_service" }
        ListElement { name: "Jazz Radio"; url: "http://jazzradio.ice.infomaniak.ch/jazzradio-high.mp3" }
        ListElement { name: "Classic FM"; url: "http://media-ice.musicradio.com/ClassicFMMP3" }
    }

    property int currentStation: 0

    property int currentMode: 1

    property bool playPauseState: false

    property bool playRadioMusicStat: false



    Rectangle {
        id: audioPlayer
        anchors.centerIn: parent
        color: "black"
        height: parent.height * 0.90
        width: parent.width * 0.45

        MediaPlayer {
           id: musicPlayerAudio
           source: "../assets/slow_Music.mp3" // Change to absolute path if needed
           audioOutput: musicPlayerAudioOutput
        }
        AudioOutput{
            id: musicPlayerAudioOutput
            volume: volumeSlider.value
        }


        Image {
           id: prevButton
           anchors{
                left: audioPlayer.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
           }
           height: parent.height * 0.85
           fillMode: Image.PreserveAspectFit
           source: "../assets/previous.png"
           MouseArea{
               anchors.fill: parent
               onClicked: {
                   if(playPauseState){
                       if(playRadioMusicStat) {
                           currentStation = (currentStation - 1 + stationList.count) % stationList.count;
                           radioPlayer.source = stationList.get(currentStation).url;
                           radioPlayer.play();
                       }
                   }
                }
            }
        }

        Image {
            id: playPauseButton
            anchors{
                left: prevButton.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            height: parent.height * 0.85
            fillMode: Image.PreserveAspectFit
            source: ( playPauseState ? "../assets/pause-button.png" : "../assets/play.png" )
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (playPauseState) {
                        musicPlayerAudio.pause();
                        radioPlayer.pause();
                    } else {
                        if (playRadioMusicStat) {
                            radioPlayer.source = stationList.get(currentStation).url;
                            radioPlayer.play();
                            musicPlayerAudio.pause();
                        } else {
                            musicPlayerAudio.play();
                            radioPlayer.pause();
                        }
                    }
                    playPauseState = !playPauseState;
                }
            }
        }
        Image {
            id: nextButton
            anchors{
                left: playPauseButton.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            height: parent.height * 0.85
            fillMode: Image.PreserveAspectFit
            source: "../assets/next-button.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(playPauseState){
                        if(playRadioMusicStat) {
                            currentStation = (currentStation + 1) % stationList.count;
                            radioPlayer.source = stationList.get(currentStation).url;
                            radioPlayer.play();
                        }
                    }
                }
            }
        }
        Image {
            id: modeButton
            anchors{
                left: nextButton.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            height: parent.height * 0.85
            fillMode: Image.PreserveAspectFit
            source: "../assets/mode.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {

                   // currentMode = (currentMode + 1) % 3;

                    if (playPauseState) {
                        if (playRadioMusicStat) {
                            musicPlayerAudio.play();
                            radioPlayer.pause();
                        } else {
                            radioPlayer.source = stationList.get(currentStation).url;
                            radioPlayer.play();
                            musicPlayerAudio.pause();
                        }
                    } else {
                        radioPlayer.stop();
                        musicPlayerAudio.stop();
                    }
                    playRadioMusicStat = !playRadioMusicStat;
                }
            }
        }
        Image {
            id: musicIcon
            anchors{
                left: modeButton.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            height: parent.height * 0.85
            fillMode: Image.PreserveAspectFit
            source: playRadioMusicStat ? "../assets/musicOff" : "../assets/music.png"
        }
        Image {
            id: radioIcon
            anchors{
                left: musicIcon.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            height: parent.height * 0.85
            fillMode: Image.PreserveAspectFit
            source: playRadioMusicStat ? "../assets/RadioOn":"../assets/RadioOff"
        }
        Text {
            anchors{
                left: radioIcon.right
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            id: stationName
            text: stationList.get(currentStation).name
            font.pixelSize: 15
            font.bold: true
            color: "white"

        }

    }


}




// MediaPlayer {
//     id: musicPlayerAudio
//     source: "../assets/slow_Music.mp3" // Change to absolute path if needed
//     audioOutput: audioOutput
//     //loops: MediaPlayer.Infinite  // Loop audio indefinitely


//     onPlaybackStateChanged: {
//         console.log("🔹 Playback State Changed:", playbackState);
//     }

//     onErrorOccurred: {
//         console.log("❌ Error:", error, " - ", errorString);
//     }
// }

// AudioOutput{
//     id: audioOutput
//     volume: 1.0
// }

// Image {
//     id: pauseButton
//     anchors{
//         left: playButton.right
//         leftMargin: 15
//         verticalCenter: parent.verticalCenter
//     }
//     height: parent.height * 0.85
//     fillMode: Image.PreserveAspectFit
//     source: "../assets/pause-button.png"
//     MouseArea{
//         anchors.fill: parent
//         onClicked: {
//             console.log("|| pause button pressed");
//             musicPlayerAudio.pause();
//         }
//     }
// }


// Image {
//     id: stopButton
//     anchors{
//         left: pauseButton.right
//         leftMargin: 15
//         verticalCenter: parent.verticalCenter
//     }
//     height: parent.height * 0.85
//     fillMode: Image.PreserveAspectFit
//     source: "../assets/stop-button.png"
//     MouseArea{
//         anchors.fill: parent
//         onClicked: {
//             console.log(" ⏹ pause button pressed");
//             musicPlayerAudio.stop();
//         }
//     }
// }

