import QtQuick 2.15
import QtQuick.Controls 2.15

import "../ui"

Item {
    id: root

    signal startBelajar(time: int)
    signal finishBelajar()

    signal requestBack()

    Button {
        id: backButton
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
        }
        width: 90

        icon.source: "../icon/left_28.svg"
        icon.width: 80
        icon.height: 80
        icon.color: "white"


        background: {}

        onClicked: root.requestBack()

    }

    MainToDoList {
        id: toDoList
        anchors {
            top: root.top
            right: root.right
            bottom: root.bottom
            left: backButton.right
            topMargin: 80
            rightMargin: 32
            bottomMargin: 32
            leftMargin: 16
        }

        onStartBelajar: (time) => root.startBelajar(time)
        onFinishBelajar: () => finishBelajar()
    }
}
