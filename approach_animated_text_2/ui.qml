/*
 * Author: Piotr Topa <pt@approach.pl>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import Shotcut.Controls 1.0

Item {
    width: 400
    height: 250
    Component.onCompleted: {
        if (filter.isNew) {
            filter.set('resource', filter.path + 'effect.html')
            // Set default parameter values
            textField.text = qsTr('Text to be displayed')
            filter.set('text', textField.text)
            filter.set('color', '#FFFFFF')
			filter.set('bgcolor', '#000000')
            filter.set('font-family', 'NotoSansBold')
	        filter.set('font-size', 72)
            filter.set('pos-y', 50)
            filter.set('opacity', 80)
            filter.set('bgopacity', 70)
            filter.savePreset(preset.parameters)
            setControls();
        }
        filter.set('in', filter.producerIn)
        filter.set('out', filter.producerOut)
    }

    function setControls() {
        colorSwatch.value = filter.get('color')
        bgcolorSwatch.value = filter.get('bgcolor')
        fontCombo.currentIndex = fontCombo.valueToIndex(filter.get('font-family'))
        fontfontSizeSlider.value = filter.getDouble('font-size')
        posYSlider.value = filter.getDouble('pos-y')
        opacitySlider.value = filter.getDouble('opactiy')
        bgopacitySlider.value = filter.getDouble('bgopactiy')
    }

    GridLayout {
        columns: 5
        anchors.fill: parent
        anchors.margins: 8

        Label {
            text: qsTr('Preset')
            Layout.alignment: Qt.AlignRight
        }
        Preset {
            id: preset
            parameters: ['color', 'bgcolor', 'font-family', 'font-size', 'pos-y', 'opacity', 'bgopacity']
            Layout.columnSpan: 4
            onPresetSelected: setControls()
        }

        Label {
            text: qsTr('Text')
            Layout.alignment: Qt.AlignRight
        }
        TextField {
            id: textField
            Layout.columnSpan: 4
            text: filter.get('text')
            Layout.minimumWidth: fontSizeSlider.width
            Layout.maximumWidth: fontSizeSlider.width
            onTextChanged: filter.set('text', text)
        }

        Label {
            text: qsTr('Font')
            Layout.alignment: Qt.AlignRight
        }
        ComboBox {
            id: fontCombo
            model: ['NotoSans Bold', 'NotoSans Regular', 'CuteFont Regular', 'Lobster Regular', 'Roboto Condensed Bold', 'Roboto Condensed Bold Italic', 'Roboto Condensed Italic', 'Roboto Condensed Regular']
            property var values: ['NotoSansBold', 'NotoSansRegular', 'CuteFontRegular', 'LobsterRegular', 'RobotoCondensedBold', 'RobotoCondensedBoldItalic', 'RobotoCondensedItalic', 'RobotoCondensedRegular']
            function valueToIndex() {
                var w = filter.get('font-family')
                for (var i = 0; i < values.length; ++i)
                    if (values[i] === w) break;
                if (i === values.length) i = 0;
                return i;
            }
            Layout.columnSpan: 4
            currentIndex: valueToIndex()
            onActivated: filter.set('font-family', values[index])
        }

        Label {
            text: qsTr('Font size')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: fontSizeSlider
            Layout.columnSpan: 3
            minimumValue: 14
            maximumValue: 200
            value: filter.getDouble('font-size')
            onValueChanged: filter.set('font-size', value)
        }
        UndoButton {
            onClicked: fontSizeSlider.value = 36
        }

        Label {
            text: qsTr('Color')
            Layout.alignment: Qt.AlignRight
        }
        ColorPicker {
            id: colorSwatch
            Layout.columnSpan: 4
            value: filter.get('color')
            property bool isReady: false
            Component.onCompleted: isReady = true
            onValueChanged: {
                if (isReady) {
                    filter.set('color', '' + value)
                    filter.set("disable", 0);
                }
            }
            onPickStarted: {
                filter.set("disable", 1);
            }
        }
		
		Label {
            text: qsTr('Background color')
            Layout.alignment: Qt.AlignRight
        }
        ColorPicker {
            id: bgcolorSwatch
            Layout.columnSpan: 4
            value: filter.get('bgcolor')
            property bool isReady: false
            Component.onCompleted: isReady = true
            onValueChanged: {
                if (isReady) {
                    filter.set('bgcolor', '' + value)
                    filter.set("disable", 0);
                }
            }
            onPickStarted: {
                filter.set("disable", 1);
            }
        }

        Label {
            text: qsTr('Vertical position')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: posYSlider
            Layout.columnSpan: 3
            minimumValue: 0
            maximumValue: 100
            value: filter.getDouble('pos-y')
            onValueChanged: filter.set('pos-y', value)
        }
        UndoButton {
            onClicked: posYSlider.value = 50
        }

        Label {
            text: qsTr('Opacity')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: opacitySlider
            Layout.columnSpan: 3
            minimumValue: 0
            maximumValue: 100
            value: filter.getDouble('opacity')
            onValueChanged: filter.set('opacity', value)
        }
        UndoButton {
            onClicked: opacitySlider.value = 80
        }

        Label {
            text: qsTr('Background opacity')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: bgopacitySlider
            Layout.columnSpan: 3
            minimumValue: 0
            maximumValue: 100
            value: filter.getDouble('bgopacity')
            onValueChanged: filter.set('bgopacity', value)
        }
        UndoButton {
            onClicked: bgopacitySlider.value = 70
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
