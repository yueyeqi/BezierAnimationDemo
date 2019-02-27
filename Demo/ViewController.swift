//
//  ViewController.swift
//  Demo
//
//  Created by payne on 2019/2/24.
//  Copyright © 2019 payne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //路径动画
//        let svg = ESSVGView(frame: view.frame)
//        view.addSubview(svg)
        
        //二维码动画
        let qr = ESXML(frame: view.frame)
        view.addSubview(qr)

    }

}


