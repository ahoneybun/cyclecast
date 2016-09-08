import QtQuick 2.4
import Ubuntu.Components 1.3
import CycleCast 1.0

MainView {
    id: mainView
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "cyclecast.ahoneybun"

    width: units.gu(50)
    height: units.gu(75)

    property var today : Qt.formatDateTime(new Date(),"ddd")
    property var tomorrow : Qt.formatDateTime(new Date(+1))
    property var currentTime : Qt.formatTime(new Date(),"hh:mm")

    property var location: "TEST!"

    AdaptivePageLayout {
        id: pageLayout
        primaryPage: page0
        anchors.fill: parent
    }

    Page {
        id: page0
        visible: false
        header: PageHeader {
            title: mainView.location.name
            StyleHints {
                foregroundColor: "white"
                backgroundColor: UbuntuColors.inkstone
                dividerColor: UbuntuColors.porcelain
            }
            leadingActionBar.actions: []
            trailingActionBar.actions: [
                Action {
                    iconName: "settings"
                    onTriggered: pageLayout.addPageToNextColumn(page0, Qt.resolvedUrl("Settings.qml"))
                },
                Action {
                    iconName: "info"
                    onTriggered: pageLayout.addPageToNextColumn(page0, Qt.resolvedUrl("About.qml"))
                }
            ]
        }

        Column {
            id: columnMain
            anchors {
                fill: parent
                top: page0.bottom
                topMargin: units.gu(6)
            }
            clip: true

            ListItem {
                trailingActions: ListItemActions {
                    actions: [
                        Action {
                            iconName: "go-next"
                            onTriggered: pageLayout.addPageToNextColumn(page0, Qt.resolvedUrl("Hours.qml"))
                        }
                    ]
                }
                ListItemLayout {
                    Icon {
                        name: "ok"
                        color: UbuntuColors.green
                        SlotsLayout.position: SlotsLayout.Leading
                        width: units.gu(2)
                    }
                    Label {
                        id: label1
                        text: "Now"
                    }
                    Label {
                        id: label2
                        text: mainView.location.weather
                    }
                }
            }
        }
// BottomEdge test
//        BottomEdge {
//            height: parent.height - units.gu(20)
//            hint.text: "My bottom edge"
//            contentComponent: Rectangle {
//                width: page.width
//                height: page.height
//                color: UbuntuColors.green
//            }
//        }
    }
}
