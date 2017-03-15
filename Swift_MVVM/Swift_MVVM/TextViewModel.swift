//
//  TextViewModel.swift
//  Swift_MVVM
//
//  Created by passionHan on 2017/3/10.
//  Copyright © 2017年 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit
let kTextViewUpdateUI = "kTextViewUpdateUI"

class TextViewModel: NSObject {
    
    var textModel: TextModel!
    dynamic var color: UIColor? //swift 使用KVO监听的属性需要用dynamic关键字声明
    
    override init() {
        super.init()
        textModel = TextModel()
        textModel.addObserver(self, forKeyPath: "color", options: [.old, .new], context: nil)
    }
    
    //模拟请求网络数据，在数据变化的时候实现自动更新视图
    public func requestData() {
        
        textModel.requestData()
    }
    
    deinit {
        textModel.removeObserver(self, forKeyPath: "color")
    }
}

extension TextViewModel {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            //这里只是介绍Model的作用（无意义），把逻辑判断放在VM中 减少了Controller中的代码
            if textModel.colorName == "yellow" {
                color = UIColor.yellow
            } else {
                color = textModel.color
            }
            //实现VM 与 V 绑定的方式 使用 通知 or KVO
            //NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: kTextViewUpdateUI), object: nil)
        }
    }
}

class TextModel: NSObject {
    
    var colorName: String?
    dynamic var color: UIColor?
    
    //提供一个获取数据的接口供ViewModel调用
    func requestData() {
        //生成随机色
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
        colorName = String(describing: red)
        color = colorRun
    }
}
