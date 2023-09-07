import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    color: "black"

    signal requestBack()

    Button {
        id: backButton
        anchors {
            top: root.top
            left: root.left
            topMargin: 50
            leftMargin: 32
        }

        icon.source: "../icon/left_28.svg"
        icon.color: "white"
        icon.width: 48
        icon.height: 48

        background: Item {}
        opacity: visible ? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 500 } }

        onClicked: stackView.pop()
    }
    Text {
        id: header
        anchors {
            verticalCenter: backButton.verticalCenter
            left: backButton.right
        }

        text: "Pengaturan"
        color: "white"

        font {
            family: "Inter Light"
            pixelSize: 48
        }

        states: [
            State {
                name: "normal"
                when: stackView.depth == 1
                AnchorChanges {
                    target: header
                    anchors.left: root.left
                }
                PropertyChanges {
                    target: header
                    anchors.leftMargin: 48
                }
                PropertyChanges {
                    target: backButton
                    visible: false
                }
            },
            State {
                name: "showBackButton"
                when: stackView.depth > 1
                AnchorChanges {
                    target: header
                    anchors.left: backButton.right
                }
                PropertyChanges {
                    target: header
                    anchors.leftMargin: 12
                }
                PropertyChanges {
                    target: backButton
                    visible: true
                }
            }
        ]

        transitions: Transition {
            AnchorAnimation { duration: 500; easing.type: Easing.OutCubic }
        }
    }



    StackView {
        id: stackView
        anchors {
            top: header.bottom
            left: root.left
            right: root.right
            bottom: root.bottom
        }

        initialItem: screenAwal
    }

    Component {
        id: screenAwal

        ScreenSettingsAwal {
            onRequestBack: () => root.requestBack()
            onRequestNavigate: (screen) => {
                                   switch (screen) {
                                       case "tampilan":
                                        stackView.push(screenTampilan)
                                        break
                                   }
                               }
        }
    }
    Component {
        id: screenTampilan

        ScreenSettingsTampilan {

        }
    }
}
