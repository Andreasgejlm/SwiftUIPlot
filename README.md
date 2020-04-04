# SwiftUIPlot

Customizable plotting tool implemented using SwiftUI.
Currently, only a line plot and a "background" line plot is supported.

## Installation

The package requires iOS 13.0+ and XCode 11.

Installation is done through Swift Package Manager:
Go to `File -> Swift Packages -> Add Package Dependency` and paste the url to this repository.

Then, in the file in which the plot is used, import using `import SwiftUIPlot`.


## Single Line Chart
The line chart view currently only supports single lines. Multiple lines will be supported at a later stage.

### Usage
The line chart can be initialized in a number of ways:

---
```swift
LineChart(yvals: [29, 43, 12, 120])
    .frame(height: 250)
```

The only necessary input argument is a Double array `yvals`, which contains the values that are to be plotted.
If only y-values are provided, the x-axis is numbered from 0 to yvals.count.

---

```swift
LineChart(xvals: [10, 11, 12, 13], yvals: [29, 43, 12, 120])
    .frame(height: 250)
```

If the data to be plotted contains a specific range of x-values, the optional input argument `xvals` can be provided as a Double array. This spaces out the values appropriately and uses the range of the provided x-values on the x-axis.

---
```swift
LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
    .frame(height: 250)
```
If specific x-axis labels are necessary, the optional argument `xlabels` can be provided as a String array.

**All provided xlabels are shown on the x-axis, independently of the y-values provided.**

---


### Modifiers
The appearance of the LineChart view can, in addition to the default view modifiers, be modified using the following:
* Arguments followed by ? are optional arguments and can be omitted if not necessary.

| Modifier | Description | Arguments |
| ------------- | -------- | ----- |
| `.backgroundStyle`  | Changes appearance of the background of the chart. | `color?`, `cornerRadius?` |
| `.lineStyle` | Modifies appearance of the plotted line. | `width?`, `color?`, `dashFrequency?`, `animation?` |
| `.horizontalAxisStyle` | Modifies appearance of x-axis. | `showText?`, `font?`, `textColor?`, `height?`* |
| `.verticalAxisStyle` | Modifies appearance of y-axis. | `showText?`, `font?`, `textColor?`, `width?`* |
| `.horizontalGridStyle` | Modifies appearance of horizontal grid lines.** | `gridLineColor?`, `gridLineWidth?`, `gridLineDashFrequency?` |
| `.verticalGridStyle` | Modifies appearance of vertical grid lines.** | `gridLineColor?`, `gridLineWidth?`, `gridLineDashFrequency?` |
| `.shaded` | Colors the area under the curve with the provided color. | `shadowColor?` |


### Examples

| Simple Initialization | Modifier example |
| ------- | ------- |
|![Simple initializations](https://i.imgur.com/nlmXyjY.png "Simple inits") | ![Modifiers](https://i.imgur.com/U6XDrzr.png "Modifier usage") |

**Code sample for simple initialization:**
```swift
VStack(spacing: 10) {
    LineChart(yvals: [29, 43, 12, 120])
        .padding([.top, .trailing])
    LineChart(xvals: [10, 11, 12, 13], yvals: [29, 43, 12, 120])
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .padding(.trailing)
}
```
**Code sample for modifier example:**
```swift
VStack(spacing: 10) {
    LineChart(yvals: [29, 43, 12, 120])
        .verticalAxisStyle(width: 30)
        .horizontalAxisStyle(height: 30)
        .backgroundStyle(color: Color.blue.opacity(0.2),
                         cornerRadius: 20)
    LineChart(xvals: [10, 11, 12, 13], yvals: [29, 43, 12, 120])
        .verticalAxisStyle(width: 30)
        .horizontalAxisStyle(height: 30)
        .lineStyle(width: 3,
                   color: Color.orange.opacity(0.7),
                   dashFrequency: 10)
        .shaded(shadowColor: Color.orange.opacity(0.2))
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .verticalAxisStyle(width: 30)
        .horizontalAxisStyle(height: 30)
        .horizontalGridStyle(gridLineWidth: 1,
                             gridLineDashFrequency: 15)
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .verticalAxisStyle(width: 30)
        .horizontalAxisStyle(height: 30)
        .verticalGridStyle(gridLineColor: Color.red.opacity(0.5),
                           gridLineWidth: 2,
                           gridLineDashFrequency: 5)
        .padding(.trailing)
    LineChart(yvals: [29, 43, 12, 120], xlabels: ["Jan", "Feb", "Mar", "Apr"])
        .verticalAxisStyle(showText: false,
                           width: 0)
        .horizontalAxisStyle(textColor: Color.blue,
                             height: 30)
        .horizontalGridStyle()
        .verticalGridStyle()
        .padding(.trailing)
}
```


## Background Line Chart
The background line chart shows two datasets; background and foreground data.
The chart is initialized with the required arguments `backgroundyvals` and `foregroundyvals`, and the optional arguments identical to the LineChart, `xvals` and `xlabels`.

### Modifiers
The modifiers from the LineChart are also usable here, in addition to the modifier:

`.backgroundShadowColor(_ shadowColor: Color = .gray)`

This controls the appearance of the filled background plot. The `.lineStyle` modifier only affects the foreground line.

### Example

<img src="https://i.imgur.com/s1SMucp.png" width="400">

**Code sample above example:**
```swift
VStack(spacing: 10) {
    BackgroundLineChart(backgroundyvals: [10, 12, 20, 14, 24, 50, 21, 24, 10],
                        foregroundyvals: [11, 12, 18, 15, 28])
    BackgroundLineChart(xvals: [21, 22, 23, 24, 35, 36, 37, 38, 39],
                        backgroundyvals: [10, 12, 20, 14, 24, 50, 21, 24, 10],
                        foregroundyvals: [11, 12, 18, 15, 28, 40, 36, 21])
        .backgroundShadowColor(Color.blue.opacity(0.4))
        .lineStyle(dashFrequency: 10)
    BackgroundLineChart(backgroundyvals: [10, 12, 20, 14, 24, 50, 21, 24, 10],
                        foregroundyvals: [11, 12, 18, 15, 28],
                        xlabels: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"])
        .backgroundShadowColor(Color.green.opacity(0.5))
}
```
