//
//  ViewController.swift
//  Swift_MVVM
//
//  Created by passionHan on 2017/3/10.
//  Copyright © 2017年 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var textView: TextView = {
        let view = TextView(viewModel: self.textViewModel)
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    private lazy var textViewModel: TextViewModel = {
       let model = TextViewModel()
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        
    }

}

