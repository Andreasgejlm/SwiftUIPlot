# SwiftUIPlot

Customizable plotting tool implemented using SwiftUI.
Supports:

* Line chart

## Installation

The package requires iOS 13.0+ and XCode 11.

Installation is done through Swift Package Manager:
Go to `File -> Swift Packages -> Add Package Dependency` and paste the url to this repository.

Then, at the top of the file, insert `import SwiftUIPlot`.

## Line Chart
Simple line chart with ability to stroke or fill lines for foreground and background effects.

|   |   |   |
| ------------- | -------- | ----- |
|![Simple initializations](https://i.imgur.com/nlmXyjY.png "Simple inits") | ![Modifiers](https://i.imgur.com/U6XDrzr.png "Modifier usage") | ![Modifiers](https://i.imgur.com/QlqvvyO.png "Modifier usage") |

### Usage
The line chart can be initialized in a number of ways:

---
```swift
LineChart(data: [LineChartInputData(yvalues: [29, 43, 12, 120])])
    .frame(height: 250)
```

The only necessary input argument is an array of `LineChartInputData`, which contains the values that are to be plotted, wrapped in a custom class.
If only y-values are provided, the x-axis is numbered from 0 to yvals.count.

---

```swift
LineChart(data: LineChartInputData(xvalues: [10, 11, 12, 13], 
                             yvalues: [29, 43, 12, 120])])
    .frame(height: 250)
```

If the data to be plotted contains a specific range of x-values, the optional input argument `xvalues` can be provided as a Double array. This spaces out the values appropriately and uses the range of the provided x-values on the x-axis.

---
```swift
LineChart(data: [LineChartInputData(xvalues: [10, 11, 12, 13], 
                              yvalues: [29, 43, 12, 120])], 
           xlabels: ["Jan", "Feb", "Mar", "Apr"])
    .frame(height: 250)
```
If specific x-axis labels are necessary, the optional argument `xlabels` can be provided as a String array.

---
```swift
LineChart(data: [LineChartInputData(xvalues: [10, 11, 12, 13], 
                             yvalues: [29, 43, 12, 120],
                             plotType: .fill,
                             curveType: .cubicBezier,
                             color: Color.gray.opacity(0.3)),
                 LineChartInputData(xvalues: [6, 8, 12],
                             yvalues: [36, 22, 21],
                             plotType: .stroke(width: 5, dashFreq: 1),
                             curveType: .segmentedLines,
                             color: Color.blue)])
    .frame(height: 250)
```
For multiple lines, simply append them to the `data` array. In order to style the lines differently, each line can be modified with the variables 
* `plotType` ( `.stroke(width: CGFloat, dashFreq: CGFloat)`  or `.fill`)
* `curveType` (`.cubicBezier` or `.segmentedLines`)
* `color`

---

**All provided xlabels are shown on the x-axis, independently of the y-values provided.**

---


### Modifiers
The appearance of the LineChart view can, in addition to the default view modifiers, be modified using the following:
* Arguments followed by ? are optional arguments and can be omitted if not necessary.

| Modifier | Description | Arguments |
| ------------- | -------- | ----- |
| `.backgroundStyle`  | Changes appearance of the background of the chart. | `color?`, `cornerRadius?` |
| `.horizontalAxisStyle` | Modifies appearance of x-axis. | `showText?`, `font?`, `textColor?`, `height?`* |
| `.verticalAxisStyle` | Modifies appearance of y-axis. | `showText?`, `font?`, `textColor?`, `width?`* |
| `.horizontalGridStyle` | Modifies appearance of horizontal grid lines.** | `gridLineColor?`, `gridLineWidth?`, `gridLineDashFrequency?` |
| `.verticalGridStyle` | Modifies appearance of vertical grid lines.** | `gridLineColor?`, `gridLineWidth?`, `gridLineDashFrequency?` |
| `.shaded` | Colors the area under the curve with the provided color. | `shadowColor?` |


