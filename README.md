# Touch Coder

## Overview

In case you like to handle touches programmatically for drawing or painting, its kind of pain to repeat touching screen over and over.  You may wonder if it can be reproduced programmatically, then here it is.

This project and its app record your touches while drawing.  These touches can be exported as a part of Swift source code.  Here is the list of properties to be exported.

| Name | Type | Description (based on UITouch documentation) |
|:-----|:-----|:------------|
| touchType | Int | 0: direct, 1: indirect, 2: stylus |
| location | (CGFloat, CGFloat) | Returns the current location of the receiver in the coordinate system of the given view.  |
| preciseLocation | (CGFloat, CGFloat) | Returns a precise location for the touch, when available. |
| majorRadius | CGFloat | The radius (in points) of the touch |
| majorRadiusTolerance | CGFloat | The tolerance (in points) of the touch’s radius. |
| timestamp| TimeInterval | The elapsed time (in seconds) from the first touch. |
| phase | UITouchPhase | The phase of the touch |
| force | CGFloat | The force of the touch, where a value of 1.0 represents the force of an average touch (predetermined by the system, not user-specific). |
| maximumPossibleForce | CGFloat | The maximum possible force for a touch. |
| altitudeAngle | CGFloat | The altitude (in radians) of the stylus. |
| azimuthAngle | CGFloat | Returns the azimuth angle (in radians) of the stylus. |
| azimuthUnitVector | (CGFloat, CGFloat) | Returns a unit vector that points in the direction of the azimuth of the stylus. |

Here is the example of exported code.

```swift:sample
typealias Point = (
	touchType: Int, location: (CGFloat, CGFloat), preciseLocation: (CGFloat, CGFloat), majorRadius: CGFloat, majorRadiusTolerance: CGFloat, timestamp: TimeInterval, 
	force: CGFloat, maximumPossibleForce: CGFloat, altitudeAngle: CGFloat, azimuthAngle: CGFloat, azimuthUnitVector: (CGFloat, CGFloat) 
)

[[	Point(2, (355.03125, 684.459045410156), (355.03125, 684.459045410156), 0.25, 0.0, 0.0, 0.333333333333333,4.16666666666667, 0.793895081677709, 1.04037475585938, (0.505897030655754, 0.862593875687563)), 
	Point(2, (355.296875, 683.854614257812), (355.296875, 683.854614257812), 0.25, 0.0, 0.0129999999990105, 0.2078125,4.16666666666667, 0.793895081677709, 1.04037475585938, (0.505897030655754, 0.862593875687563)), 
	Point(2, (355.5625, 683.39599609375), (355.5625, 683.39599609375), 0.25, 0.0, 0.0169999999998254, 0.145052083333333,4.16666666666667, 0.793895081677709, 1.04037475585938, (0.505897030655754, 0.862593875687563)), 
	Point(2, (355.703125, 683.125061035156), (355.703125, 683.125061035156), 0.25, 0.0, 0.0210000000006403, 0.113671875,4.16666666666667, 0.793895081677709, 1.04037475585938, (0.505897030655754, 0.862593875687563)),
	...
Point(2, (477.71875, 651.880615234375), (477.71875, 651.880615234375), 0.25, 0.0, 0.26299999999901, 0.0,4.16666666666667, 0.793895081677709, 1.09376525878906, (0.459143716617349, 0.888362002502813))
],
[	Point(2, (426.5625, 640.083251953125), (426.5625, 640.083251953125), 0.25, 0.0, 0.0, 0.333333333333333,4.16666666666667, 0.791362122693334, 1.10859680175781, (0.445917921389058, 0.895073855826469)), 
	Point(2, (426.4375, 639.624633789062), (426.4375, 639.624633789062), 0.25, 0.0, 0.00500000000465661, 0.333333333333333,4.16666666666667, 0.791362122693334, 1.10859680175781, (0.445917921389058, 0.895073855826469)), 
	...
Point(2, (456.8125, 775.628540039062), (456.8125, 775.628540039062), 0.25, 0.0, 0.525000000001455, 0.115626017252604,4.16666666666667, 0.849620179333959, 1.10678100585938, (0.447542456811074, 0.894262684758515))
]]	 
```

Whole code can be obtain from here:
https://gist.github.com/codelynx/9147adc6ad4eaac89ca66c8ad2b24036

<img width="160" src="https://qiita-image-store.s3.amazonaws.com/0/65634/79dc5b3d-fe61-8115-cfe9-558453110edf.png" />


As you can see, all the touch properties can be exported as a Swift code.  There are however, not UITouch, therefore, you will have to tweak it for your code to use.


## How to use the App?

Once you launch the App, you will find a blank screen on the screen.  Then you can touch screen to draw.  You may erase the screen with Trash icon.  Once, you finished drawing, then tap on action button, then you can choose how to share the the code.



