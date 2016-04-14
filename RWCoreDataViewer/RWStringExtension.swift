//
//  CDDStringExtension.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/14/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthConstrainedToHeigth(height: CGFloat, font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        return (self as NSString).sizeWithAttributes(fontAttributes).width
    }
}