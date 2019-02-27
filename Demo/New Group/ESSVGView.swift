//
//  ESSVGView.swift
//  yupao
//
//  Created by payne on 2019/2/21.
//  Copyright © 2019 payne. All rights reserved.
//

import UIKit

class ESSVGView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        drawBezierPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawBezierPath() {
       
        //通过PaintCode生成的代码
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: 179.5, y: 36.5))
        pathPath.addCurve(to: CGPoint(x: 52.5, y: 118.5), controlPoint1: CGPoint(x: 95.5, y: 81.5), controlPoint2: CGPoint(x: 52.5, y: 118.5))
        pathPath.addLine(to: CGPoint(x: 263.5, y: 118.5))
        pathPath.addCurve(to: CGPoint(x: 75.5, y: 253.5), controlPoint1: CGPoint(x: 263.5, y: 118.5), controlPoint2: CGPoint(x: 4.5, y: 205.5))
        pathPath.addCurve(to: CGPoint(x: 263.5, y: 253.5), controlPoint1: CGPoint(x: 146.5, y: 301.5), controlPoint2: CGPoint(x: 263.5, y: 253.5))
        pathPath.addCurve(to: CGPoint(x: 75.5, y: 378.5), controlPoint1: CGPoint(x: 263.5, y: 253.5), controlPoint2: CGPoint(x: 222.5, y: 413.5))
        pathPath.addCurve(to: CGPoint(x: 134.5, y: 527.5), controlPoint1: CGPoint(x: -71.5, y: 343.5), controlPoint2: CGPoint(x: 134.5, y: 527.5))
        pathPath.addLine(to: CGPoint(x: 263.5, y: 404.5))
        
        //添加path到ShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.frame = frame
        pathLayer.bounds = frame
        pathLayer.isGeometryFlipped = false
        pathLayer.path = pathPath.cgPath
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 3
        pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
        layer.addSublayer(pathLayer)
        
        //添加动画
        let animation = CABasicAnimation(keyPath: "strokeEnd") //strokeEnd正常绘制效果，strokeStart逐渐消失效果
        animation.fromValue = 0 //初始值
        animation.toValue = 1 //结束值
        animation.repeatCount = 10 //重复次数
        animation.duration = 10 //动画时间
        pathLayer.add(animation, forKey: nil)
        
    }

}
