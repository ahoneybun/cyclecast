import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: aboutPage
    header: PageHeader {
        id: pageHeader
        title: i18n.tr("About")
        StyleHints {
            foregroundColor: "white"
            backgroundColor: UbuntuColors.inkstone
            dividerColor: UbuntuColors.silk
        }
        trailingActionBar.actions: []
    }

    Column {
        anchors {
            fill: parent
            top: aboutPage.bottom
            topMargin: units.gu(6)
        }
        ListItem {
            ListItemLayout {
                Label {
                    text: i18n.tr("Name:" + " " + "CycleCast")
                }
            }
        }
        ListItem {
            ListItemLayout {
                Label {
                    text: i18n.tr("Version:" + " " + "0.5")
                }
            }
        }
        ListItem {
            ListItemLayout {
                Label {
                    text: i18n.tr("Backend API: " + "OpenWeatherMap")
                }
            }
        }
        ListItem {
            ListItemLayout {
                Label {
                    text: i18n.tr("Developer:" + " " + "Aaron Honeycutt")
                }
            }
        }
    }
}

