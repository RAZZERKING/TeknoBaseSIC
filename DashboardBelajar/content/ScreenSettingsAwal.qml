import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    signal requestBack()
    signal requestNavigate(screen: string)

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
        opacity: 0.5

        onClicked: root.requestBack()
    }

    RowLayout {
        anchors.centerIn: root

        Rectangle {
            id: tampilanButtonContainer
            Layout.rightMargin: 32
            width: 300
            height: 350

            color: "#292929"
            radius: 24

            Button {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: tampilanButtonText.bottom
                }
                icon.width: 120
                icon.height: 120
                icon.source: "../icon/style_24.svg"
                icon.color: "white"

                background: Item {}
            }

            Text {
                id: tampilanButtonText
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 32
                }

                text: "Tampilan"
                color: "white"

                font {
                    family: "Inter Medium"
                    pixelSize: 42
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: requestNavigate("tampilan")
            }
        }

        Rectangle {
            id: systemButtonContainer
            width: 300
            height: 350

            color: "#292929"
            radius: 24

            Button {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: systemButtonText.bottom
                }
                icon.width: 120
                icon.height: 120
                icon.source: "../icon/desktop_24.svg"
                icon.color: "white"

                background: Item {}
            }

            Text {
                id: systemButtonText
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 32
                }

                text: "Sistem"
                color: "white"

                font {
                    family: "Inter Medium"
                    pixelSize: 42
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: requestNavigate("sistem")
            }
        }
    }
}
