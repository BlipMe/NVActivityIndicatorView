//
//  NVActivityIndicatorAnimationBarScale.swift
//  NVActivityIndicatorViewDemo
//
// The MIT License (MIT)

// Copyright (c) 2017 Nikolay Derkach

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

class NVActivityIndicatorAnimationBlipMe: NVActivityIndicatorAnimationDelegate {

    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let lineSize = CGFloat(4.0)
        let x = (layer.bounds.size.width - size.width) / 2
        let y = (layer.bounds.size.height - size.height) / 2
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.0, 0.25, 0.5]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let colors = [UIColor(red: 1.0, green: 193/255, blue: 25/255, alpha: 1.0),
                      UIColor(red: 0.0, green: 101/255, blue: 239/255, alpha: 1.0),
                      UIColor(red: 31/255, green: 185/255, blue: 1.0, alpha: 1.0)]

        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")

        animation.keyTimes = [0, 0.25, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [0.5, 1.0, 0.5]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw lines
        for i in 0 ..< 3 {
            let line = NVActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: colors[i])
            let frame = CGRect(x: x + lineSize * 3 * CGFloat(i), y: y, width: lineSize, height: size.height)

            animation.beginTime = beginTime + beginTimes[i]
            line.frame = frame
            line.add(animation, forKey: "animation")
            layer.addSublayer(line)
        }
    }
}
