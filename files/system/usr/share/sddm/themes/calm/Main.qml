import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#FFFFFF"

    ColumnLayout {
        id: form
        anchors.centerIn: parent
        width: 280
        spacing: 24

        // ── Username ──────────────────────────────────────────────────────────
        Item {
            Layout.fillWidth: true
            height: 40

            TextInput {
                id: userInput
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom; bottomMargin: 4 }
                text: userModel.lastUser
                font.family: "Go Mono"
                font.pixelSize: 15
                color: "#1A1714"
                selectionColor: "#000000"
                KeyNavigation.tab: passInput
                Keys.onReturnPressed: passInput.forceActiveFocus()
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }
            }

            Text {
                anchors { left: parent.left; bottom: parent.bottom; bottomMargin: 4 }
                visible: userInput.text === ""
                text: "username"
                font.family: "Go Mono"
                font.pixelSize: 15
                color: "#AAAAAA"
            }

            Rectangle {
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                height: 1
                color: userInput.activeFocus ? "#000000" : "#AAAAAA"
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }

        // ── Password ──────────────────────────────────────────────────────────
        Item {
            Layout.fillWidth: true
            height: 40

            TextInput {
                id: passInput
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom; bottomMargin: 4 }
                echoMode: TextInput.Password
                passwordCharacter: "•"
                font.family: "Go Mono"
                font.pixelSize: 15
                color: "#1A1714"
                selectionColor: "#000000"
                Keys.onReturnPressed: doLogin()
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }
            }

            Text {
                anchors { left: parent.left; bottom: parent.bottom; bottomMargin: 4 }
                visible: passInput.text === ""
                text: "password"
                font.family: "Go Mono"
                font.pixelSize: 15
                color: "#AAAAAA"
            }

            Rectangle {
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                height: 1
                color: passInput.activeFocus ? "#000000" : "#AAAAAA"
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }

        // ── Error ─────────────────────────────────────────────────────────────
        Text {
            id: errorMsg
            Layout.fillWidth: true
            visible: text !== ""
            text: ""
            font.family: "Go Mono"
            font.pixelSize: 12
            color: "#CC4444"
            horizontalAlignment: Text.AlignHCenter
        }

        // ── Sign in button ────────────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            height: 44
            color: signInMouse.containsMouse ? "#333333" : "#000000"
            Behavior on color { ColorAnimation { duration: 150 } }

            Text {
                anchors.centerIn: parent
                text: "sign in"
                font.family: "Go Mono"
                font.pixelSize: 13
                font.letterSpacing: 2
                color: "#FFFFFF"
            }

            MouseArea {
                id: signInMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: doLogin()
            }
        }
    }

    // ── Bottom row ────────────────────────────────────────────────────────────
    Row {
        id: bottomRow
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 36
        }
        spacing: 24

        // Session selector — underline style
        Item {
            width: 160
            height: 28
            anchors.verticalCenter: parent.verticalCenter

            ComboBox {
                id: sessionCombo
                model: sessionModel
                index: sessionModel.lastIndex
                width: parent.width
                height: parent.height
                font.family: "Go Mono"
                font.pixelSize: 15
                textColor: "#AAAAAA"
                borderColor: "transparent"
                focusColor: "transparent"
                hoverColor: "transparent"
                arrowIcon: Qt.resolvedUrl("blank.svg")
                arrowColor: "transparent"
            }

            // Underline
            Rectangle {
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                height: 1
                color: "#AAAAAA"
            }
        }

        // Reboot
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "reboot"
            font.family: "Go Mono"
            font.pixelSize: 15
            color: rebootMouse.containsMouse ? "#1A1714" : "#AAAAAA"
            Behavior on color { ColorAnimation { duration: 150 } }
            MouseArea {
                id: rebootMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }

        // Power off
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "power off"
            font.family: "Go Mono"
            font.pixelSize: 15
            color: powerMouse.containsMouse ? "#1A1714" : "#AAAAAA"
            Behavior on color { ColorAnimation { duration: 150 } }
            MouseArea {
                id: powerMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
    }

    // ── Logic ─────────────────────────────────────────────────────────────────
    function doLogin() {
        errorMsg.text = ""
        if (userInput.text === "") {
            errorMsg.text = "please enter a username"
            return
        }
        sddm.login(userInput.text, passInput.text, sessionCombo.index)
    }

    Connections {
        target: sddm
        onLoginFailed: {
            errorMsg.text = "incorrect password"
            passInput.text = ""
            passInput.forceActiveFocus()
        }
    }

    Component.onCompleted: {
        passInput.forceActiveFocus()
    }
}
