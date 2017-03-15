//
//  TextView.swift
//  Swift_MVVM
//
//  Created by passionHan on 2017/3/10.
//  Copyright © 2017年 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit

class TextView: UIView {
    
    fileprivate lazy var button: UIButton = {
       let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        btn.setTitle("换装", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.titleLabel?.textColor = UIColor.black
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return btn
    }()
    
    var textViewModel: TextViewModel!
    init(viewModel: TextViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textViewModel = viewModel
        //添加子视图
        setupSubViews()
        //绑定ViewModel， 使用 通知 or KVO
        bindingViewModel()
        //请求数据
        textViewModel.requestData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
        textViewModel.removeObserver(self, forKeyPath: "color")
    }
}

private var myContext = 0
fileprivate extension TextView {
    func setupSubViews() {
        addSubview(button)
    }
    
    func bindingViewModel() {
        //使用通知
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: kTextViewUpdateUI), object: nil, queue: OperationQueue.main) { [weak self] notify in
//            guard let strongSelf = self else {
//                return
//            }
//            strongSelf.backgroundColor = strongSelf.textViewModel.color
//        }
        //使用KVO，监听color属性的变化
        textViewModel.addObserver(self, forKeyPath: "color", options: [.new, .old], context: &myContext)
    }
    
    @objc func buttonDidClick() {
        textViewModel.requestData()
    }
}

extension TextView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            backgroundColor = textViewModel.color
        }
    }
}


