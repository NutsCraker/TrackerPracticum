//
//  UIColors.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

extension UIColor {
    
    static var YPBlack = hexStringToUIColor(hex:"#1A1B22")
    static var YPBlackNight = hexStringToUIColor(hex:"#FFFFFF")
    static var YPWhite = hexStringToUIColor(hex:"#FFFFFF")
    static var YPWhiteNight = hexStringToUIColor(hex:"#1A1B22")
    static var YPBlue = hexStringToUIColor(hex:"#3772E7")
    static var YPRed = hexStringToUIColor(hex:"#F56B6C")
    static var YPGray = hexStringToUIColor(hex:"#AEAFB4")
    static var YPLightGray = hexStringToUIColor(hex:"#E6E8EB")
    static var YPBackground = hexStringToUIColor(hex:"E6E8EB")
    static var YPBackgroundNight = hexStringToUIColor(hex:"#414141")
    static var YPSelected = hexStringToUIColor(hex:"#E6E8EB")
    
    static var CS01 = hexStringToUIColor(hex:"#FD4C49")
    static var CS02 = hexStringToUIColor(hex:"#FF881E")
    static var CS03 = hexStringToUIColor(hex:"#007BFA")
    static var CS04 = hexStringToUIColor(hex:"#6E44FE")
    static var CS05 = hexStringToUIColor(hex:"#33CF69")
    static var CS06 = hexStringToUIColor(hex:"#E66DD4")
    static var CS07 = hexStringToUIColor(hex:"#F9D4D4")
    static var CS08 = hexStringToUIColor(hex:"#34A7FE")
    static var CS09 = hexStringToUIColor(hex:"#46E69D")
    static var CS10 = hexStringToUIColor(hex:"#35347C")
    static var CS11 = hexStringToUIColor(hex:"#FF674D")
    static var CS12 = hexStringToUIColor(hex:"#FF99CC")
    static var CS13 = hexStringToUIColor(hex:"#F6C48B")
    static var CS14 = hexStringToUIColor(hex:"#7994F5")
    static var CS15 = hexStringToUIColor(hex:"#832CF1")
    static var CS16 = hexStringToUIColor(hex:"#AD56DA")
    static var CS17 = hexStringToUIColor(hex:"#8D72E6")
    static var CS18 = hexStringToUIColor(hex:"#2FD058")
    
    var hexString: String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }
    
}
extension String {
    var color: UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: self).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
