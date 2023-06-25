//
//  UIColors.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

extension UIColor {
    
    static let ypBackgroundColor = UIColor(named: "backgroundColor") ?? UIColor.red
    static let ypSwitchColor = UIColor(named: "switchColor") ?? UIColor.blue
    static let ypGradient01 = UIColor(named: "gradientColor1") ?? UIColor.red
    static let ypGradient02 = UIColor(named: "gradientColor2") ?? UIColor.green
    static let ypFradient03 = UIColor(named: "gradientColor3") ?? UIColor.blue
    static let ypDatePicker = UIColor(named: "datePickerColor") ?? UIColor.gray
    static let ypDatePickerTint = UIColor(named: "datePickerTintColor") ?? UIColor.black
    static let ypSearchColor = UIColor(named: "searchTextFieldColor") ?? UIColor.gray
    static let ypGray = UIColor(named: "ypGray") ?? UIColor.gray
    static let ypWhite = UIColor(named: "ypWhite") ?? UIColor.white
    static let ypRed = UIColor(named: "ypRed") ?? UIColor.red
    static let ypBlack = UIColor(named: "ypBlack") ?? UIColor.black
    static let yplightGray = UIColor(named: "lightGray") ?? UIColor.gray
    static let ypBlue = UIColor(named: "ypBlue") ?? UIColor.blue
    
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
final class Colors {
    var viewBackgroundColor = UIColor.systemBackground
    var datePickerTintColor = UIColor { (traits) -> UIColor in
        let isDarkMode = traits.userInterfaceStyle == .dark
        return isDarkMode ? UIColor.black : UIColor.black
    }
}
public extension UIView {
    
    private static let kLayerNameGradientBorder = "GradientBorderLayer"
    
    func setGradientBorder(
        width: CGFloat,
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0, y: 0.5),
        endPoint: CGPoint = CGPoint(x: 1, y: 0.5)
    ) {
        let existedBorder = gradientBorderLayer()
        let border = existedBorder ?? CAGradientLayer()
        border.frame = bounds
        border.colors = colors.map { return $0.cgColor }
        border.startPoint = startPoint
        border.endPoint = endPoint
        
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = width
        
        border.mask = mask
        
        let exists = existedBorder != nil
        if !exists {
            layer.addSublayer(border)
        }
    }
    
    func removeGradientBorder() {
        self.gradientBorderLayer()?.removeFromSuperlayer()
    }
    
    private func gradientBorderLayer() -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
        if borderLayers?.count ?? 0 > 1 {
            fatalError()
        }
        return borderLayers?.first as? CAGradientLayer
    }
}
