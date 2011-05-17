import Qt 4.7
import "utils.js" as Utils

Item {
    id : root
    height : 800
    width : 424
    property int rotateFlag : 0
    property int keyboardOffset
    property int textviewPartHeight
    property alias sideSpacing : textViewPart.sideSpacing
    property alias keyWidth : keyboard.keyWidth
    property alias keyHeight : keyboard.keyHeight
    property alias numKeyWidth : keyboard.numKeyWidth
    property alias numKeyHeight : keyboard.numKeyHeight
    property alias useIKey_l : keyboard.useIKey_l
    property alias textview : textViewPart.view

    Palette { id : palette }
    Config { id : config }
    Rectangle {
        anchors.fill : parent
        color : palette.backgroundColor
    }
    Image {
        id : backgroundImage
        anchors.fill : parent
        fillMode : Image.PreserveAspectCrop
        source : config.backgroundImagePath
        visible : config.backgroundImageVisible
        opacity : config.backgroundImageOpacity
    }
    RootMouseArea {
        id : mouseLayer
        anchors.fill : parent
        Text {
            x : 5 ; y : 5
            text : Utils.modeString[keyboard.mode]
            color : palette.keyNormalColor
            font.pointSize: 26; font.bold: true
        }
        TextViewPart {
            id : textViewPart
            x : 0 ; y : 0
            width : parent.width ; height : textviewPartHeight
        }
        Keyboard {
            id : keyboard
            width : keyWidth * 11
            height : numKeyHeight + keyHeight * 4
            x : keyboardOffset
            y : textviewPartHeight
        }
    }
    RealMouseArea {
        anchors.fill : parent
        useMouseTracker : true
        ProxyMouseArea {
            anchors.fill : parent
            target : mouseLayer
        }
    }
    Preedit {
        id : preedit
        anchors.horizontalCenter : parent.horizontalCenteR
        y : ( textViewPart.height - height ) / 2
    }
    Tooltip {
        id : tooltip
        height : 100
    }
    function setText( text ) {
        textview.set( text )
        imEngine.clear()
        keyboard.updateCandString()
    }
    function getText() {
        return textview.get()
    }
    function setRotate( flag ) {
        rotateFlag = flag
    }

    states {
        State {
            name : "LAND" ; when : rotateFlag == 0
            PropertyChanges {
                target : root
                width : 800
                height : 424
                keyboardOffset : -30
                textviewPartHeight : 75
                sideSpacing : 70
                keyWidth : 800 / 10 * 0.975
                keyHeight : keyWidth * 0.975
                numKeyWidth : keyWidth
                numKeyHeight : numKeyWidth * 0.925
                useIKey_l : true
            }
        } 
        State {
            name : "PORT" ; when : rotateFlag == 1
            PropertyChanges {
                target : root
                width : 480
                height : 700
                keyboardOffset : -18
                textviewPartHeight : 160
                sideSpacing : 45
                keyWidth : 480 / 10 * 0.975 * 1.045
                keyHeight : keyWidth * 1.75
                numKeyWidth : keyWidth 
                numKeyHeight : numKeyWidth * 1.75
                useIKey_l : false
            }
        } 
    }
}
