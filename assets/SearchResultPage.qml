import bb.cascades 1.0
import bb.system 1.0

Page {
    Container {
        ListView{
            dataModel: routeVM.resultDataModel

            listItemComponents: [
                ListItemComponent {
                    type: "item"

                    Container {
                        background: ListItem.active ? Color.create("#CC00A8DF") : (ListItem.selected ? Color.create("#00A8DF") : Color.Transparent)
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            topPadding: 10.0
                            leftPadding: 10.0
                            rightPadding: 10.0
                            bottomPadding: 10.0
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }

                            Container {
                                preferredWidth: 125

                                Container {
                                    Label {
                                        text: Qt.formatDateTime(ListItemData.departure.time, "hh:mm")
                                        textStyle.color: Color.Gray
                                    }
                                    Label {
                                        text: Qt.formatDateTime(ListItemData.arrival.time, "hh:mm")
                                        textStyle.color: Color.Gray
                                    }
                                    /*Label {
                                        text: "+" + (ListItemData.departure.delay / 60)
                                        textStyle.color: Color.Red
                                        textStyle.fontSize: FontSize.XSmall
                                        visible: ListItemData.departure.delay != 0
                                        horizontalAlignment: HorizontalAlignment.Center
                                    }*/
                                }
                            }
                            Container {
                                Label {
                                    text: ListItemData.departure.name
                                }
                                Label {
                                    text: ListItemData.arrival.name
                                }
                            }
                            Container {
                                leftMargin: 50
                                Label {
                                    preferredWidth: 60
                                    text: ListItemData.departure.platform == 0 ? "-" : ListItemData.departure.platform
                                    textStyle.textAlign: TextAlign.Right
                                }
                                Label {
                                    preferredWidth: 60
                                    text: ListItemData.arrival.platform == 0 ? "-" : ListItemData.arrival.platform
                                    textStyle.textAlign: TextAlign.Right
                                }
                            }
                            Container {
                                verticalAlignment: VerticalAlignment.Center
                                leftMargin: 50.0

                                Label {
                                    text: Qt.formatTime(ListItemData.duration, "hh:mm")
                                }
                            }
                            Container {
                                verticalAlignment: VerticalAlignment.Center
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1.0
                                }

                                Label {
                                    text: "+" + (ListItemData.departure.delay / 60)
                                    textStyle.color: Color.Red
                                    textStyle.fontSize: FontSize.XSmall
                                    horizontalAlignment: HorizontalAlignment.Right
                                    visible: ListItemData.departure.delay != 0
                                }
                            }
                        }
                        Container {
                            preferredHeight: 2
                            preferredWidth: 800
                            background: Color.create("#eeeeee")
                        }
                    }
                }
            ]
            onTriggered: {
                routeVM.select(indexPath)
            }
        }
    }
    actions: [
        ActionItem {
            title: routeVM.favorite ? qsTr("Geen favoriet") : qsTr("Favoriet")
            imageSource: routeVM.favorite ? "asset:///images/bb_action_unfavorite.png" : "asset:///images/bb_action_favorite.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                routeVM.favoriteMe()
                favoriteToast.show()
            }
        }
    ]
    attachedObjects: [
        SystemToast {
            id: favoriteToast
            body: routeVM.favorite ? qsTr("Toegevoegd aan uw favorieten.") : qsTr("Verwijderd uit uw favorieten.")
        }
    ]
}
