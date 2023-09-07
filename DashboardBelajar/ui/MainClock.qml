import QtQuick 2.15

Text {
    id: clockText

    text: "10:12"

    color: "white"

    font {
        family: "Inter"
        pointSize: 80
        weight: "Bold"
    }

    function updateClock() {
        const date = new Date()
        clockText.text =
            convertToTwoDigit(date.getHours()) + ":" + convertToTwoDigit(date.getMinutes())
    }

    function convertToTwoDigit(number) {
        if (number < 10)
            return "0" + number
        else
            return number
    }

    Timer {
        interval: 1000
        repeat: true
        onTriggered: updateClock()
        running: true
    }

    Component.onCompleted: {
        updateClock()
    }
}
