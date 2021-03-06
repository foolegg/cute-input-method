import Qt 4.7
import Qt.labs.gestures 1.0

Rectangle {
    id : background
    width : 80
    height : 80
    color : "#00000000"
    property int keycode
    property string title
    property string subtitle

    Rectangle {
        id : plat
        anchors.centerIn: parent
        width : parent.width * 0.985
        height : parent.height - parent.width + width
        color : "#FF444444"

        Text {
            id : titleText
            text : title
            anchors.centerIn : parent
            color : "#FFFFFFFF"
            font.pointSize: 30; font.bold: true
        }

        Text {
            id : subtitleText
            text : subtitle
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.bottom : parent.bottom
            anchors.bottomMargin : parent.height * 0.05
            color : "#FFCCCCCC"
            font.pointSize: 12; font.bold: false
        }
    }

    MouseArea {
        id : mouseArea
        focus : false
        anchors.fill : parent
        hoverEnabled : false
        onPressed : {}
        onReleased : {}
    }

    states {
        State {
            name : "down" ; when : mouseArea.pressed == true && mouseArea.containsMouse == true
            PropertyChanges { target : plat ; color : "#FF2299FF" }
        } 
    }

    transitions {
        Transition {
            from : "" ; to : "down" ; reversible : false
            ParallelAnimation {
                ColorAnimation { target : plat ; duration : 128 }
            }
        } 
        Transition {
            from : "down" ; to : "" ; reversible : false
            ParallelAnimation {
                ColorAnimation { target : plat ; duration : 256 }
            }
        } 
    }
}
