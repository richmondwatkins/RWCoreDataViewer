//
//  CDDStringExtension.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/14/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthConstrainedToHeigth(_ height: CGFloat, font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        return (self as NSString).size(attributes: fontAttributes).width
    }
}
