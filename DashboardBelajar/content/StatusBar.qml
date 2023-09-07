import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    height: 50

    visible: false

    transform: Translate { id: rootTranslate }

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#252525" }
        GradientStop { position: 1.0; color: "#000000" }
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
        id: clock
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
            leftMargin: 14
        }

        color: "white"

        text: "➡️ 30 Menit menuju belajar"

        font {
            pixelSize: 30
            family: "Inter Light"
            //weight: "Bold"
        }
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
