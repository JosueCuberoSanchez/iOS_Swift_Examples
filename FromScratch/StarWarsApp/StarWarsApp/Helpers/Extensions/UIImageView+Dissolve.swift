//
//  UIImageView+rx.swift
//  StarWarsApp
//
//  Created by Josue on 1/23/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIImageView {

    func crossDissolveImage(_ image: UIImage) {
        UIView.transition(
            with: self,
            duration: 1.5,
            options: .transitionCrossDissolve,
            animations: { self.image = image },
            completion: nil
        )
    }
}
