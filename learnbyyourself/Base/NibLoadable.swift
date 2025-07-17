//
//  NibLoadable.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

protocol NibLoadable: AnyObject {
    static func instantiateFromNib() -> Self
}


extension NibLoadable where Self: UIViewController {
    static func instantiateFromNib() -> Self {
        return Self(nibName: String(describing: Self.self), bundle: nil)
    }
}
