//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Josue on 1/4/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = Observable.of("Hello RxSwift")
    }


}

