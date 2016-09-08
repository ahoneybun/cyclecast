import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: settingsPage

    property variant currentData: undefined;
    property variant forecastData: undefined;

    Component.onCompleted: console.debug("Location: ", mainView.location)

    function requestWeaCity () {
        var request = new XMLHttpRequest ();
        request.onreadystatechange = function () {
            if (request.readyState == XMLHttpRequest.DONE) {
                if (request.status == 200) {
                    currentData = JSON.parse (request.responseText);
                    print("have search results", currentData["list"].length);
                    for (var i = 0; i < currentData["list"].length; i++) {
                        var entry = currentData["list"][i]
                        print("have search result entry:", entry["id"], entry["name"], entry["weather"][0]["main"])
                        locationModel.append( { id: entry["id"], name: entry["name"], weather: entry["weather"][0]["main"] } )
                    }
                } else {
                    console.log ("HTTP request failed", request.status);
                }
            }
        }
        print("Have query:", "http://api.openweathermap.org/data/2.5/find?q=" + searchLocation.displayText + "&appid=753a953085551461ddf5555c772c06c2")
        request.open ("GET", "http://api.openweathermap.org/data/2.5/find?q=" + searchLocation.displayText + "&appid=753a953085551461ddf5555c772c06c2");
        request.send ();
    }

    header: PageHeader {
        id: pageHeader
        title: i18n.tr("Settings")
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
            top: settingsPage.bottom
            topMargin: units.gu(6)
        }

        ListItem {
            ListItemLayout {
                Label {
                    text: i18n.tr("Select your location then push the back button")
                }
            }
        }

        ListItem {
            ListItemLayout {
                focus: true
                TextField { id: searchLocation; placeholderText: "Search by City or Zip Code" }
                    Keys.onEnterPressed: { requestWeaCity() }

                Button { text: "Enter"
                    onClicked: requestWeaCity() }
            }
        }
        Repeater {
            model: ListModel {
                id: locationModel
                property int selectedIndex: -1
            }
            ListItem {
                ListItemLayout {
                    title.text: model.name + " " + model.weather
                }
                onClicked: {
                    print("user clicked on", model.id, model.name, model.weather)
                    mainView.location = model
                }
            }
        }
    }
}

