import QtQuick
import QtQuick.Controls.Material

Item {
    id: applicationProductHeader

    signal backRequested()

    height: rectangleButtonBackground.height

    Rectangle {
        id: rectangleButtonBackground

        x: (toolButtonBack.width - width)/2
        y: (toolButtonBack.height - height)/2
        width: toolButtonBack.width - toolButtonBack.leftPadding - toolButtonBack.rightPadding
        height: width
        radius: width/2
        color: "#70000000"
    }

    ToolButton {
        id: toolButtonBack

        icon.source: "qrc:/images/icons/arrows/arrow_back.svg"
        icon.color: "white"
        onClicked: {
            applicationProductHeader.backRequested()
        }
    }
}
