//
//  UIView+Ex.swift
//  onlineStore
//
//  Created by aaa on 2/5/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
