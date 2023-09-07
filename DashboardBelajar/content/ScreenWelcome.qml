import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.12

Item {
    id: root

    signal firstAnimationFinished()

    signal animationFinished()


    Timer {
        interval: 1000
        onTriggered: {
            welcomeAnimation1.start()
        }
        running: true
    }
    Timer {
        id: afterWelcomeAnimationTimer
        interval: 2000
        onTriggered: {
            welcomeAnimation2.start()
        }
    }


    GaussianBlur {
        id: blurEffect
        anchors.fill: parent
        source: Image {
            id: backgroundImage

            source: "../data/pemandangan.jpg"

            fillMode: Image.PreserveAspectFit


            //opacity: 0
        }
        radius: 0

        transform: Translate { id: backgroundImageTranslate; y: -1366 }
    }

    Row {
        id: textContainer
        anchors.centerIn: parent

        scale: 0

        //transform: Scale { id: textContainerTranslate; sca: 0 }
        opacity: 0

        Text {
            text: "Hai!"
            font.pointSize: 80
            font.family: "Inter"
            font.weight: "Bold"
            color: "white"
        }

        Text {
            id: wavingHand
            //anchors.verticalCenter: textContainer
            text: "👋"
            font.pointSize: 80

            transform: Rotation { id: textContainerRotation; angle: 0; axis.z: 1; origin.x: 100; origin.y: 100 }
        } 
    }

    SequentialAnimation {
        id: welcomeAnimation1

        onFinished: {
            afterWelcomeAnimationTimer.start()
            firstAnimationFinished()
        }

        NumberAnimation {
            target: backgroundImageTranslate
            property: "y"
            duration: 1500
            to: 0
            easing.type: Easing.OutCubic
        }

        ParallelAnimation {
            NumberAnimation {
                target: blurEffect
                property: "radius"
                duration: 1000
                to: 24
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: blurEffect
                property: "opacity"
                duration: 1000
                to: 0.5
            }

            NumberAnimation {
                target: textContainer
                property: "scale"
                duration: 1000
                from: 0
                to: 1
                easing.type: Easing.OutElastic
            }

            NumberAnimation {
                target: textContainer
                property: "opacity"
                duration: 1000
                from: 0
                to: 1
                easing.type: Easing.OutCubic
            }
        }

        NumberAnimation {
            target: textContainerRotation
            property: "angle"
            duration: 750
            to: 70
            easing.type: Easing.InCubic
        }
        NumberAnimation {
            target: textContainerRotation
            property: "angle"
            duration: 750
            to: -40
            easing.type: Easing.InOutCubic
        }
        NumberAnimation {
            target: textContainerRotation
            property: "angle"
            duration: 750
            to: 0
            easing.type: Easing.OutCubic
        }
    }

    SequentialAnimation {
        id: welcomeAnimation2

        onFinished: animationFinished()

        NumberAnimation {
            target: textContainer
            property: "scale"
            duration: 500
            to: 1.4
            easing.type: Easing.InOutCubic
        }

        ParallelAnimation {
            NumberAnimation {
                target: textContainer
                property: "scale"
                duration: 500
                to: 0
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: textContainer
                property: "opacity"
                duration: 500
                to: 0
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: blurEffect
                property: "scale"
                duration: 750
                to: 0
                easing.type: Easing.InCubic
            }

            NumberAnimation {
                target: blurEffect
                property: "opacity"
                duration: 750
                to: 0
                easing.type: Easing.InCubic
            }
        }
    }
}
