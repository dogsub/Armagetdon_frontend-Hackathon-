//
//  UIColor+Hex.swift
//  Armagetdon
//
//  Created by 김동섭 on 7/5/24.
//

import UIKit

extension UIColor {
   convenience init(hex: String, alpha: CGFloat = 1.0) {
       var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
       hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

       var rgbValue: UInt64 = 0
       Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

       let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
       let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
       let b = CGFloat(rgbValue & 0x0000FF) / 255.0

       self.init(red: r, green: g, blue: b, alpha: alpha)
   }
}
