//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Josue on 12/28/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            let url = URL(string: "https://img.purch.com/w/660/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzAxNi82MDMvb3JpZ2luYWwvZWFydGgtZnJvbS1zcGFjZS5qcGc=")
            if let imageVC = segue.destination.contents as? ImageViewController {
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
