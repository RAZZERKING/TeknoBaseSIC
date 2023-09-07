import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../jsonlistmodel"

import "../moment.js" as Moment
import "../timeHelper.js" as TimeHelper

Rectangle {
    id: root

    width: 450
    height: 550

    color: "white"
    radius: 24

    signal startBelajar(time: int)
    signal finishBelajar()

    Component.onCompleted: {
        console.log(backend.getJadwal()[0]["jam"])
        //jadwal = backend.getJadwal()
    }

    Text {
        id: header
        anchors {
            top: root.top
            left: root.left
            topMargin: 16
            leftMargin: 20
        }

        text: "📑Jadwal Belajar"
        font {
            family: "Inter Semibold"
            pixelSize: 40
        }
    }

    ListView {
        id: listView
        anchors {
            top: header.bottom
            left: root.left
            right: root.right
            bottom: root.bottom
            topMargin: 16
            leftMargin: 20
            rightMargin: 20
        }

        model: dataModel.model

        clip: true

        delegate: ColumnLayout {
            Layout.margins: 24

            anchors {
                left: listView.left
                right: listView.right
            }

            RowLayout {
                Layout.margins: 12
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    id: listDecor

                    width: 24
                    height: 24

                    radius: width / 2
                    color: {
                        let random = Math.floor(Math.random() * 5)
                        return ["blue", "red", "gray", "green", "purple"][random]
                    }
                }

                Text {
                    //Layout.leftMargin:

                    text: "<b>Dari</b> " + TimeHelper.convertToTwoDigit(model.jam) + ":" + TimeHelper.convertToTwoDigit(model.menit)

                    font {
                        pixelSize: 20
                    }
                }
                Text {
                    Layout.leftMargin: 12

                    text: {
                        let waktu = TimeHelper.addTime(model.jam, model.menit, model.berapaLama)

                        return "<b>Sampai →</b>" + waktu.jam + ":" + waktu.menit
                    }

                    font {
                        pixelSize: 20
                    }
                }

                Text {
                    Layout.fillWidth: true

                    text: model.berapaLama + " menit"
                    horizontalAlignment: Qt.AlignRight

                    font {
                        pixelSize: 20
                        italic: true
                    }
                }

                Button {
                    id: removeButton

                    background: Rectangle {}
                    icon {
                        source: '../icon/remove_28.svg'
                        color: 'red'
                    }

                    onClicked: {
                        backend.removeJadwal(model.index)
                        listView.updateModel()
                    }
                }

                Timer {
                    id: timerStart

                    interval: {
                        let date = new Date()
                        let berapaDetikLagi = 0

                        console.log('abc', model.jam, model.menit, date.getHours(), date.getMinutes())

                        if (model.jam > date.getHours()) {
                            console.log('interval YES 1')
                            berapaDetikLagi = ((model.jam - date.getHours()) * 60) + model.menit
                            console.log('interval YES 1 time: ', berapaDetikLagi)
                        } else {
                            if (model.jam == date.getHours() && model.menit > date.getMinutes()) {
                                console.log('interval YES 2', model.menit, date.getMinutes())
                                berapaDetikLagi = ((model.menit - date.getMinutes()) * 60)
                                console.log('interval YES 2 time: ', berapaDetikLagi)
                            }
                            console.log('interval NO')
                        }

                        console.log("interval " + berapaDetikLagi * 1000)

                        return berapaDetikLagi * 1000
                    }

                    running: {
                        let date = new Date()
                        let kondisi = false

                        if (model.jam > date.getHours()) {
                            console.log('kondisi', '1')
                            kondisi = true
                        } else {
                            console.log('kondisi', '2')
                            if (model.jam == date.getHours() && model.menit > date.getMinutes()) {
                                console.log('kondisi', '3')
                                kondisi = true
                            }
                        }

                        console.log('kondisi running', kondisi)

                        return kondisi
                    }


                    onTriggered: {
                        console.log("TIMER TIMER TIMER jam " + model.jam + " menit " + model.menit)
                        root.startBelajar(model.berapaLama)
                    }
                }
            }

            Rectangle {
                id: divider
                Layout.fillWidth: true

                height: 1

                color: "gray"
            }
        }

        JSONListModel {
            id: dataModel
            source: "../data.json"
        }

        function updateModel() {
            dataModel.source = ""
            dataModel.source = "../data.json"
        }
    }

    Button {
        id: addButton
        padding: 24
        anchors {
            right: root.right
            bottom: root.bottom
            rightMargin: 24
            bottomMargin: 24
        }
        highlighted: false

        icon {
            color: "#ffffff"
            source: "../icon/add_24.svg"
            width: 48
            height: 48
        }

        font {
            family: "Inter"
            weight: "Bold"
            pixelSize: 42
        }

        background: Rectangle {
            color: "#7cdb7c"
            radius: width / 2
        }

        onClicked: {
            addDialog.open()
        }
    }

    Dialog {
        id: addDialog
        anchors {
            centerIn: root
        }

        //width: 400

        title: "Tambah jadwal"
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true
        //opened: true

        ColumnLayout {
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                Column {
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Jam"
                    }
                    Tumbler {
                        id: addHourTumbler
                        model: 25
                        currentIndex: {
                            let date = new Date()
                            return date.getHours()
                        }
                    }
                }
                Column {
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Menit"
                    }
                    Tumbler {
                        id: addMinuteTumbler
                        model: 60
                        currentIndex: {
                            let date = new Date()
                            return date.getMinutes()
                        }
                    }
                }
            }
            RowLayout {
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Berapa lama:"
                }
                SpinBox {
                    id: addBerapaLamaTumbler
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Menit"
                }

            }
        }

        onAccepted: {
            backend.addJadwal(addHourTumbler.currentIndex, addMinuteTumbler.currentIndex, addBerapaLamaTumbler.value)
            listView.updateModel()
        }
    }
}
