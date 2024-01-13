import QtQuick 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640; height: 480

    property date dateTime: new Date()

    readonly property string sessionName: sessionModel.data(sessionModel.index(sessionModel.lastIndex, 0), Qt.UserRole + 4)
    readonly property string userName: userModel.data(userModel.index(userModel.lastIndex, 0), Qt.UserRole + 1)

    readonly property color backgroundColor: config.backgroundColor || "#000000"
    readonly property color errorColor: config.errorColor || "#FF0000"
    readonly property color foregroundColor: config.foregroundColor || "#FFFFFF"
    readonly property int fontSize: config.fontSize || 24
    readonly property string fontFamily: config.fontFamily || "monospace"
    readonly property string passwordChar: config.passwordCharacter || "*"

    Connections {
        target: sddm
        function onLoginSucceeded() {
            backgroundBorder.border.width = 0
            animateBorder.stop()
        }
        function onLoginFailed() {
            backgroundBorder.border.width = 5
            animateBorder.restart()
            passwordInput.clear()
        }
        function onInformationMessage() {
        }
    }
    Item {
        id: main
        property variant geometry: screenModel.geometry(screenModel.primary)
        width: geometry.width ; height: geometry.height
        x: geometry.x ; y: geometry.y
        Rectangle {
            id: background
            anchors.fill: parent
            color: backgroundColor
            Rectangle {
                id: backgroundBorder
                anchors.fill: parent
                border.color: errorColor ; border.width: 0
                color: "transparent"
                z: 3
                Behavior on border.width {
                    SequentialAnimation {
                        id: animateBorder
                        running: false
                        loops: Animation.Infinite
                        NumberAnimation { from: 5 ; to: 10 ; duration: 700 }
                        NumberAnimation { from: 10 ; to: 5 ;  duration: 400 }
                    }
                }
            }
        }
        Column {
            id: clock
            Timer {
                interval: 100 ; repeat: true ; running: true
                onTriggered: dateTime = new Date()
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: foregroundColor
                font.family: fontFamily ; font.pointSize: fontSize / 2
                font.letterSpacing: 20 / 96 * fontSize / 2
                text : Qt.formatTime(dateTime, "hh:mm:ss")
            }
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top ; topMargin: fontSize
            }
        }
        Text {
            id: username
            color: foregroundColor
            font.bold: false ; font.italic: true
            font.letterSpacing: 20 / 96 * fontSize / 2
            font.family: fontFamily ; font.pointSize: fontSize
            text: userName
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: password.top
            }
        }
        TextInput {
            id: password
            clip: true
            color: foregroundColor
            echoMode: TextInput.Password
            font.bold: true
            font.family: fontFamily ; font.pointSize: fontSize
            font.letterSpacing: 20 / 96 * fontSize
            horizontalAlignment: TextInput.AlignHCenter ; verticalAlignment: TextInput.AlignVCenter
            passwordCharacter: passwordChar
            selectedTextColor: backgroundColor ; selectionColor: foregroundColor
            width: parent.width / 2 ; height: 200 / 96 * fontSize
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            onAccepted: {
                if (text != "") { sddm.login(userModel.lastUser || "root", text, sessionModel.lastIndex); }
            }
            cursorDelegate: Rectangle {
                id: cursor
                anchors.verticalCenter: parent.verticalCenter
                color: foregroundColor
                onHeightChanged: height = password.height / 2
                width: 10 / 96 * fontSize
                Glow {
                    anchors.fill: cursor
                    color: cursor.color
                    radius: 4 / 96 * fontSize
                    samples: 2 * radius + 1
                    source: cursor
                }
            }
        }
        Text {
            id: session
            color: foregroundColor
            font.bold: false ; font.italic: false
            font.letterSpacing: 20 / 96 * fontSize / 2
            font.family: fontFamily ; font.pointSize: fontSize / 2
            text: sessionName
            anchors {
                bottom: parent.bottom ; bottomMargin: fontSize
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            id: shutdown
            color: foregroundColor
            font.family: fontFamily ; font.pointSize: fontSize / 2
            text: "^S: shutdown"
            visible: sddm.canPowerOff
            anchors {
                bottom: parent.bottom ; bottomMargin: fontSize
                left: parent.left ; leftMargin: fontSize
            }
        }
        Shortcut {
            sequence: "Ctrl-S"
            onActivated: {
                if (sddm.canPowerOff) { sddm.powerOff(); }
            }
        }
        Text {
            id: reboot
            color: foregroundColor
            font.family: fontFamily ; font.pointSize: fontSize / 2
            text: "^R: reboot"
            visible: sddm.canReboot
            anchors {
                bottom: parent.bottom ; bottomMargin: fontSize
                right: parent.right ; rightMargin: fontSize
            }
        }
        Shortcut {
            sequence: "Ctrl-R"
            onActivated: {
                if (sddm.canReboot) { sddm.reboot(); }
            }
        }
        Component.onCompleted: {
            password.forceActiveFocus();
        }

    }
}

