import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Rectangle {
    id: root

    color: "#50000000"

    signal requestBack()
    signal requestToSettings()


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

    RowLayout {
        anchors.centerIn: root

        /*ColumnLayout {
            Layout.rightMargin: 48

            Button {
                Layout.alignment: Qt.AlignHCenter

                icon.source: "../icon/settings_48.svg"
                icon.width: 80
                icon.height: 80
                icon.color: "white"

                background: {}

                onClicked: root.requestToSettings()
            }
            Text {
                text: "Pengaturan"
                color: "white"

                font {
                    pixelSize: 24
                    weight: "Bold"
                    family: "Inter"
                }
            }
        }*/
        ColumnLayout {
            Layout.rightMargin: 48

            Button {
                Layout.alignment: Qt.AlignHCenter

                icon.source: "../icon/dismiss_48.svg"
                icon.width: 80
                icon.height: 80
                icon.color: "white"

                background: {}

                onClicked: backend.closeApp()
            }
            Text {
                Layout.alignment: Qt.AlignHCenter

                text: "Keluar"
                color: "white"

                font {
                    pixelSize: 24
                    weight: "Bold"
                    family: "Inter"
                }
            }
        }
        ColumnLayout {
            Button {
                Layout.alignment: Qt.AlignHCenter

                icon.source: "../icon/power_28.svg"
                icon.width: 80
                icon.height: 80
                icon.color: "white"

                background: {}

                onClicked: backend.shutdown()
            }
            Text {
                text: "Matikan"
                color: "white"

                font {
                    pixelSize: 24
                    weight: "Bold"
                    family: "Inter"
                }
            }
        }
    }
}
