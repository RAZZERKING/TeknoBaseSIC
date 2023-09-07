import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    signal startBelajar(time: int)
    signal finishBelajar()
    signal requestToSettings()

    property string isInWhere: 'main'

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "../data/pemandangan2.jpg"

        fillMode: Image.PreserveAspectCrop

        transform: Translate { id: backgroundImageTranslate }


    }

    Item {
        id: screenContainer
        anchors.fill: root

        //scale: 0.5

        clip: false

        Behavior on scale { PropertyAnimation { easing.type: Easing.OutCubic } }

        ScreenMainClock {
            id: clockScreen
            anchors.fill: parent

            Behavior on opacity { PropertyAnimation {} }
        }

        ScreenMainJadwal {
            id: jadwalScreen
            anchors.fill: parent

            visible: opacity != 0

            opacity: 0
            scale: 0.4

            Behavior on opacity { PropertyAnimation {} }

            onStartBelajar: (time) => root.startBelajar(time)
            onFinishBelajar: () => finishBelajar()
            onRequestBack: () => {
                               root.isInWhere = 'main'
                               pinchArea.enabled = true
                               screenContainer.scale = 1
                               clockScreen.opacity = 1
                               jadwalScreen.opacity = 0
                           }
        }

        ScreenMainOptions {
            id: optionsScreen
            anchors.fill: parent

            visible: opacity != 0

            opacity: 0
            scale: 2

            Behavior on opacity { PropertyAnimation {} }

            onRequestBack: () => {
                               root.isInWhere = 'main'
                               pinchArea.enabled = true
                               screenContainer.scale = 1
                               clockScreen.opacity = 1
                               optionsScreen.opacity = 0
                           }
            onRequestToSettings: () => {
                                    root.requestToSettings()
                                 }
        }
    }

    PinchArea {
        id: pinchArea
        anchors.fill: root

        property double lastScale: 1

        onPinchUpdated: (pinch) => {
                            let scaleReal
                            if (root.isInWhere == 'main') {
                                scaleReal = pinch.scale > 0.5 && pinch.scale < 2.5 ? pinch.scale : lastScale
                            }/* else {
                                scaleReal = pinch.scale > -2.5 && pinch.scale < 1.5 ? pinch.scale : lastScale
                            }*/

                            screenContainer.scale = scaleReal

                            console.log("scaleReal: " + scaleReal + " , scale: " + pinch.scale + " , scale(-0.5): " + (scaleReal - 0.5))

                            if (root.isInWhere == 'main') {
                                let clockScreenOpacity = scaleReal - 1

                                clockScreen.opacity -= clockScreenOpacity
                                jadwalScreen.opacity = scaleReal - 1

                            }/* else {
                                let jadwalScreenOpacity = scaleReal - 1

                                clockScreen.opacity = scaleReal + 1
                                jadwalScreen.opacity += jadwalScreenOpacity
                            }*/

                            lastScale = scaleReal
                        }

        onPinchFinished: {
            if (root.isInWhere == 'main') {
                if (pinch.scale > 2) {
                    screenContainer.scale = 2.5
                    root.isInWhere = 'jadwal'

                    clockScreen.opacity = 0
                    jadwalScreen.opacity = 1

                    enabled = false
                } else if(pinch.scale < 0.8) {
                    screenContainer.scale = 0.5
                    root.isInWhere = 'options'

                    clockScreen.opacity = 0
                    optionsScreen.opacity = 1

                    enabled = false
                } else {
                    screenContainer.scale = 1

                    clockScreen.opacity = 1
                    jadwalScreen.opacity = 0
                }
            }/* else {
                if (pinch.scale < 0.8) {
                    screenContainer.scale = 1
                    screenContainer.isInMain = true

                    clockScreen.opacity = 1
                    jadwalScreen.opacity = 0
                } else {
                    screenContainer.scale = 2.5

                    clockScreen.opacity = 0
                    jadwalScreen.opacity = 1
                }
            }*/

            lastScale = 1
        }
    }

    ParallelAnimation {
        id: enterAnimation

        running: true

        NumberAnimation {
            target: backgroundImageTranslate
            property: "x"
            duration: 2000
            from: 1000
            to: 0
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: backgroundImage
            property: "opacity"
            duration: 1500
            from: 0
            to: 1
            easing.type: Easing.Linear
        }
    }

    Text {
        anchors.bottom: root.bottom
        id: debugText

        color: "white"
    }
}

