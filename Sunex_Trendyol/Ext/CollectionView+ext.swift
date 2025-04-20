//
//  CollectionView+ext.swift
//  Sunex_Trendyol
//
//  Created by User on 18.04.25.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier:String {
        String(describing: self)
    }
    
    static var nib :UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}
