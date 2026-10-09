import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    width: 200
    height: 40
    
    WlrLayerShell.layer: WlrLayerShell.Top
    WlrLayerShell.exclusiveZone: 40

    Rectangle {
        anchors.fill: parent
        color: "#111411"

        Text {
            anchors.centerIn: parent
            text: "BOOTSTRAP"
            color: "#85d993"
            font.pixelSize: 16
            font.bold: true
        }
    }
}
