import QtQuick 2.15

import "../ui"

Item {
    id: root

    MainClock {
        id: clockText
        anchors {
            left: dateText.left
            bottom: dateText.top
        }

        transform: Translate { id: clockTextTranslate }
    }
    MainDate {
        id: dateText
        anchors {
            left: root.left
            bottom: root.bottom
            leftMargin: 32
            bottomMargin: 32
        }

        transform: Translate { id: dateTextTranslate }
    }

    ParallelAnimation {
        id: enterAnimation

        running: true

        NumberAnimation {
            target: clockTextTranslate
            property: "x"
            duration: 1500
            from: 800
            to: 0
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: clockText
            property: "opacity"
            duration: 1500
            from: 0
            to: 1
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: dateTextTranslate
            property: "x"
            duration: 1250
            from: 600
            to: 0
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: dateText
            property: "opacity"
            duration: 1250
            from: 0
            to: 1
            easing.type: Easing.OutCubic
        }
        /*NumberAnimation {
            target: toDoList
            property: "opacity"
            duration: 1250
            from: 0
            to: 1
            easing.type: Easing.OutCubic
        }*/
    }
}
