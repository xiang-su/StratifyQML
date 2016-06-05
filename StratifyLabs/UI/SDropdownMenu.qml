/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import QtQuick 2.6
import "."

SList {
    id: base;
    type: "listgroup";
    delegate: listDelegate;
    blockWidth: true;

    implicitHeight: listViewObject.count * (font_size + padding_vertical*5);
    listViewObject.spacing: 0;

    signal clicked();

    property var target: parent;
    property string activeText;

    Component {
        id: listDelegate;

        SContainer {
            id: container;
            parent: base.parent;
            SText {
                id: text;
                blockWidth: true;
                text: model.text;
            }
            MouseArea {
                width: container.width;
                height: text.height;
                hoverEnabled: true;

                onEntered: {
                    text.text_color = Theme.dropdown_link_hover_color;
                    container.background = Theme.dropdown_link_hover_bg;
                    startHover();
                }

                onExited: {
                    text.text_color = Theme.text_color;
                    container.background = "transparent";
                    stopHover;
                }

                onClicked: {
                    base.visible = false;
                    base.activeText = text.text;
                    base.clicked();
                }

            }


        }
    }


    Rectangle {
        anchors.fill: parent;
        color: Theme.dropdown_bg;
        radius: Theme.btn_border_radius_base;
        border.color: Theme.dropdown_border;
        z:-1;
    }

    Rectangle {
        anchors.fill: parent;
        color: "transparent";
        border.color: Theme.dropdown_border;
        radius: Theme.btn_border_radius_base;
        z:1;
    }

}