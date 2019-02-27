//
//  ESXML.swift
//  yupao
//
//  Created by payne on 2019/2/22.
//  Copyright © 2019 payne. All rights reserved.
//

import UIKit

class ESXML: UIView {
    
    var rects = [CGRect]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        //解析SVG文件
        let qrPath = Bundle.main.path(forResource: "qr", ofType: "svg")!
        let qrData = NSData(contentsOfFile: qrPath)
        let xmlParser = XMLParser(data: qrData! as Data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ESXML: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "use" {
            //但elementName等于use的时候，记录rect并添加的rects数组中
            let x = Double(attributeDict["x"]!)
            let y = Double(attributeDict["y"]!)
            let rect = CGRect(x: x!, y: y!, width: 12, height: 12)
            rects.append(rect)
        }else if elementName == "svg" {
            //elementName等于svg的时候，记录这个二维码大小
            let w = Double(attributeDict["width"]!)
            let h = Double(attributeDict["height"]!)
            bounds = CGRect(x: 0, y: 0, width: w!, height: h!)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        //给layer添加阴影
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        
        //遍历rects数组，把每一个rect变为一个贝塞尔路径，并用一个CAShapeLayer承载，最后添加动画。
        for r in rects {
            let rectLayer = CAShapeLayer()
            
            rectLayer.fillColor = UIColor.orange.cgColor
            rectLayer.strokeColor = nil
            rectLayer.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: r.size)).cgPath
            rectLayer.frame = r
            
            var startTransform = CATransform3DIdentity
            startTransform.m34 = 1.0 / -20  // 透视
            startTransform = CATransform3DRotate(startTransform, CGFloat(Double.pi)*0.5, 0, 1, 0)  // 沿 y 轴旋转 π/2 圈，待会再动画转回来

            // transform 动画
            let transAnim = CABasicAnimation(keyPath: "transform")
            transAnim.duration = drand48() * 2  // 随机一个持续时间
            transAnim.fromValue = NSValue(caTransform3D: startTransform)
            transAnim.toValue = NSValue(caTransform3D: CATransform3DIdentity)
            transAnim.repeatCount = 5
            rectLayer.add(transAnim, forKey: "transAnim")

            // 透明度动画
            let alphaAnim = CABasicAnimation(keyPath: "opacity")
            alphaAnim.duration = transAnim.duration
            alphaAnim.fromValue = 0
            alphaAnim.toValue = 1
            alphaAnim.repeatCount = 5
            rectLayer.add(alphaAnim, forKey: "alphaAnim")
            
            layer.addSublayer(rectLayer)
        }
    }
}
