//
//  UIView+Additions.swift
//  FirebaseChat
//
//  Created by Mobdev125 on 10/23/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import UIKit

extension UIView {
    
    func smoothRoundCorners(to radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: radius
            ).cgPath
        
        layer.mask = maskLayer
    }
    
}
