import QtQuick 2.15

Text {
    id: dateText

    text: "September, 04/09/2023"

    color: "white"

    font {
        family: "Inter Light"
        pointSize: 40
    }

    transform: Translate { id: dateTextTranslate }

    Component.onCompleted: {
        const date = new Date()

        dateText.text =
            convertToDayName(date.getDay()) + ", " +
            convertToTwoDigit(date.getDate()) + "/" +
            convertToTwoDigit(date.getMonth()) + "/" +
            date.getFullYear()
    }

    function convertToDayName(day) {
        const dayName = [
            "Minggu",
            "Senin",
            "Selasa",
            "Rabu",
            "Kamis",
            "Jumat",
            "Sabtu"
        ]
        return dayName[day]
    }

    function convertToTwoDigit(number) {
        if (number < 9)
            return "0" + number
        else
            return number
    }
}
