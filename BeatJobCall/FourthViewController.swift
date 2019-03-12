//
//  FourthViewController.swift
//  BeatJobCall
//
//  Created by Shunichi Kitao on 2019/02/09.
//  Copyright © 2019年 Shunichi Kitao. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func goHome(_ sender: Any) {

        //ViewControlloerの画面に遷移する
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
  

}
