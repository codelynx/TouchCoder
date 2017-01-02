//
//	TouchView.swift
//	TouchCoder
//
//	Created by Kaz Yoshikawa on 1/2/17.
//	Copyright © 2017 Electricwoods LLC. All rights reserved.
//

import UIKit


typealias Point = (
	type: Int, location: (CGFloat, CGFloat), preciseLocation: (CGFloat, CGFloat), majorRadius: CGFloat, majorRadiusTolerance: CGFloat, timestamp: TimeInterval, 
	force: CGFloat, maximumPossibleForce: CGFloat, altitudeAngle: CGFloat, azimuthAngle: CGFloat, azimuthUnitVector: (CGFloat, CGFloat) 
)


class TouchPoint {
	var touchType: Int
	var location: CGPoint
	var preciseLocation: CGPoint
	var majorRadius: CGFloat
	var majorRadiusTolerance: CGFloat
	var timestamp: TimeInterval
	var phase: UITouchPhase
	var force: CGFloat
	var maximumPossibleForce: CGFloat
	var altitudeAngle: CGFloat
	var azimuthAngle: CGFloat
	var azimuthUnitVector: CGVector
	
	init(touch: UITouch, view: UIView) {
		self.touchType = touch.type.rawValue
		self.location = touch.location(in: view)
		self.preciseLocation = touch.preciseLocation(in: view)
		self.majorRadius = touch.majorRadius
		self.majorRadiusTolerance = touch.majorRadiusTolerance
		self.timestamp = touch.timestamp
		self.phase = touch.phase
		self.force = touch.force
		self.maximumPossibleForce = touch.maximumPossibleForce
		self.altitudeAngle = touch.altitudeAngle
		self.azimuthAngle = touch.azimuthAngle(in: view)
		self.azimuthUnitVector = touch.azimuthUnitVector(in: view)
	}
	
}


class TouchStroke {
	var touchPoints: [TouchPoint]

	init(_ touchPoints: [TouchPoint]) {
		self.touchPoints = touchPoints
	}

	func append(_ touchPoints: [TouchPoint]) {
		self.touchPoints += touchPoints
	}

	var string: String {
		guard let t0 = touchPoints.first?.timestamp else { return "" }
		let strings = touchPoints.map {
				"\tPoint(" +
				"\($0.touchType), " +
				"(\($0.location.x), \($0.location.y)), " +
				"(\($0.preciseLocation.x), \($0.preciseLocation.y)), " +
				"\($0.majorRadius), \($0.majorRadiusTolerance), \($0.timestamp - t0), " +
				"\($0.force),\($0.maximumPossibleForce), \($0.altitudeAngle), \($0.azimuthAngle), " +
				"(\($0.azimuthUnitVector.dx), \($0.azimuthUnitVector.dy))" +
				")"
		}
		return strings.joined(separator: ", \n")
	}
}


class TouchView: UIView {

	var strokes = [TouchStroke]()
	var touchStrokeDictionary = [UITouch: TouchStroke]()

	func drawStroke(_ touchStroke: TouchStroke) {
		let bezierPath = UIBezierPath()
		bezierPath.lineWidth = 2
		var lastPoint: TouchPoint?
		for touchPoint in touchStroke.touchPoints {
			if let _ = lastPoint {
				bezierPath.addLine(to: touchPoint.location)
			}
			else {
				bezierPath.move(to: touchPoint.location)
			}
			lastPoint = touchPoint
		}
		bezierPath.stroke()
	}

	override func draw(_ rect: CGRect) {
		for stroke in self.strokes {
			self.drawStroke(stroke)
		}
		
		for (_, stroke) in touchStrokeDictionary {
			drawStroke(stroke)
		}
	}
	
	func erase() {
		self.strokes = []
		self.setNeedsDisplay()
	}
	
	func codeString() -> String {
		let typeString =
			"typealias Point = (\n" +
			"\ttouchType: Int, location: (CGFloat, CGFloat), preciseLocation: (CGFloat, CGFloat), majorRadius: CGFloat, majorRadiusTolerance: CGFloat, timestamp: TimeInterval, \n" +
			"\tforce: CGFloat, maximumPossibleForce: CGFloat, altitudeAngle: CGFloat, azimuthAngle: CGFloat, azimuthUnitVector: (CGFloat, CGFloat) \n" +
			")\n\n"

		return typeString + "[" + strokes.map { "[" + $0.string + "\n]" }.joined(separator: ",\n") + "]"
	}
	
	// mark: -

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let touchPoint = TouchPoint(touch: touch, view: self)
			let stroke = TouchStroke([touchPoint])
			touchStrokeDictionary[touch] = stroke
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			if let stroke = self.touchStrokeDictionary[touch],
			   let coalescedTouches = event?.coalescedTouches(for: touch) {
				stroke.append(coalescedTouches.map { TouchPoint(touch: $0, view: self) })
			}
		}
		self.setNeedsDisplay()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			if let stroke = self.touchStrokeDictionary[touch] {
				self.strokes.append(stroke)
			}
			self.touchStrokeDictionary[touch] = nil
		}
		self.setNeedsDisplay()
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			self.touchStrokeDictionary[touch] = nil
		}
		self.setNeedsDisplay()
	}
	
}
