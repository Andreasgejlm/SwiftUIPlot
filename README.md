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

**The y-values do not have to be normalized, or match the height of the view.**

This is done automatically in the view. If only y-values are provided, the x-axis is numbered from 0 to yvals.count.

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

## Background Line Chart
h


### Modifiers
