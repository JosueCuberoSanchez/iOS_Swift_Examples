//
//  UITableView+RegisterDequeue.swift
//  StarWarsApp
//
//  Created by Josue on 1/29/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {

    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = String(describing: cellType)
        register(T.self, forCellWithReuseIdentifier: className)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T
    }

}
