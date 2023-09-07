import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12

Window {
    id: root

    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")

    color: "black"

    //flags: Qt.WindowStaysOnTopHint

    visibility: "FullScreen"

    Component.onCompleted: {
        //backend.startBeep(5)
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: screenWelcome
        //replaceEnter: {}

        transform: [
            Rotation {
                angle: 0
                axis { x: 0; y: 1; z: 0 }
                origin { x: 0; y: stackView.height / 2 }
            }
        ]

        pushEnter: Transition {
            ScaleAnimator {
                from: 4
                to: 1
                duration: 1200
                easing.type: Easing.InOutCubic
            }
            OpacityAnimator {
                from: 0
                to: 1
                duration: 1200
                easing.type: Easing.InCubic
            }
        }
        pushExit: Transition {
            ScaleAnimator {
                from: 1
                to: 0.2
                duration: 800
                easing.type: Easing.InOutCubic
            }
            OpacityAnimator {
                from: 1
                to: 0
                duration: 800
                easing.type: Easing.InOutCubic
            }
        }

        popEnter: Transition {
            ScaleAnimator {
                from: 0.2
                to: 1
                duration: 1200
                easing.type: Easing.InOutCubic
            }
            OpacityAnimator {
                from: 0
                to: 1
                duration: 1200
                easing.type: Easing.InCubic
            }
        }
        popExit: Transition {
            ScaleAnimator {
                from: 1
                to: 4
                duration: 800
                easing.type: Easing.InOutCubic
            }
            OpacityAnimator {
                from: 1
                to: 0
                duration: 800
                easing.type: Easing.InOutCubic
            }
        }
    }

    Component {
        id: screenWelcome
        ScreenWelcome {
            onAnimationFinished: (abc) => {
                stackView.replace(screenWelcome, screenMain)
                statusBarShowTimer.start()
            }
        }
    }
    Component {
        id: screenMain
        ScreenMain {
            onStartBelajar: (time) => statusBar.mulaiBelajar(time)
            onFinishBelajar: () => finishBelajar()
            onRequestToSettings: () => stackView.push(screenSettings)
        }
    }
    Component {
        id: screenSettings
        ScreenSettingsMain {
            onRequestBack: stackView.pop()
        }
    }


    Rectangle {
        id: statusBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        property bool isBelajarNow: false
        property int waktuBelajar: 0
        property int waktuBelajarMinus: 0

        function mulaiBelajar(waktu) {
            console.log("StatusBar Mulai belajar")
            statusBar.waktuBelajar = waktu
            statusBar.waktuBelajarMinus = 0
            statusBar.isBelajarNow = true
            belajarTimer.running = true

            backend.startBeep(waktu)
        }

        function finishBelajar() {
            console.log("StatusBar Selesai belajar")
            statusBar.isBelajarNow = false
            statusBar.waktuBelajarMinus = 0
            statusBar.isBelajarNow = false

            backend.selesaiBelajarBeep()
        }

        Timer {
            id: statusBarShowTimer
            interval: 2000
            onTriggered: statusBar.showStatusBar()
        }

        Timer {
            id: belajarTimer
            interval: 1000
            repeat: true
            onTriggered: statusBar.updateWaktuBelajar()
        }

        function updateWaktuBelajar() {
            console.log('belajar TIMER')
            let waktuBelajarMilliseconds = statusBar.waktuBelajar * 1000 * 60
            statusBar.waktuBelajarMinus += 1000

            if (statusBar.waktuBelajarMinus % 60000 == 0) {
                statusBar.waktuBelajar -= 1
                statusBar.waktuBelajarMinus = 0
            }

            console.log('belajar TIMER', waktuBelajarMilliseconds, statusBar.waktuBelajarMinus)

            if (statusBar.waktuBelajarMinus >= waktuBelajarMilliseconds) {
                console.log('belajar TIMER lebih', waktuBelajarMilliseconds, statusBar.waktuBelajarMinux)
                statusBar.finishBelajar()
                belajarTimer.running = false
            }

            statusBarText.text = "<b>Waktunya belajar: </b>" + statusBar.waktuBelajar + " menit"
        }

        height: 50

        visible: false

        transform: Translate { id: rootTranslate }

        gradient: Gradient {
            GradientStop { id: statusBarGradient1; position: 0.0; color: "#252525" }
            GradientStop { id: statusBarGradient2; position: 1.0; color: "#000000" }
        }

        function showStatusBar() {
            visible = true
            enterAnimation.start()
        }

        Timer {
            interval: 1000
            repeat: true
            onTriggered: updateClock()
            //running: true
        }

        Text {
            id: statusBarText
            anchors {
                horizontalCenter: statusBar.horizontalCenter
                verticalCenter: statusBar.verticalCenter
            }

            color: "white"
            font {
                pixelSize: 24
            }

            Behavior on opacity { NumberAnimation {} }

            states: [
                State {
                    name: "normal"; when: !statusBar.isBelajarNow
                    PropertyChanges {
                        target: statusBarGradient1
                        color: "#252525"
                    }
                    PropertyChanges {
                        target: statusBarGradient2
                        color: "#000000"
                    }
                    PropertyChanges {
                        target: statusBarText
                        opacity: 0
                    }
                },
                State {
                    name: "belajar"; when: statusBar.isBelajarNow
                    PropertyChanges {
                        target: statusBarGradient1
                        color: "#3cc93c"
                    }
                    PropertyChanges {
                        target: statusBarGradient2
                        color: "#218321"
                    }
                    PropertyChanges {
                        target: statusBarText
                        opacity: 1
                    }
                }
            ]
        }

        function updateClock() {
            const date = new Date()
            clock.text = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
        }


        NumberAnimation {
            id: enterAnimation
            target: rootTranslate
            property: "y"
            duration: 1000
            from: -50
            to: 0
            easing.type: Easing.InOutCubic
        }
    }

    /*Button {
        text: "Exit"
        onClicked: backend.closeApp()
    }*/
}
