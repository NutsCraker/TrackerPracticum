//
//  UIColors.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

extension UIColor {
    static var YPBlackDay: UIColor { UIColor(named: "black") ?? UIColor.black }
    static var YPBlackNight: UIColor { UIColor(named: "white") ?? UIColor.white }
    static var YPWhiteDay: UIColor { UIColor(named: "white") ?? UIColor.white }
    static var YPWhiteNight: UIColor { UIColor(named: "black") ?? UIColor.black }
    static var YPBlue: UIColor { UIColor(named: "blue") ?? UIColor.blue }
    static var YPRed: UIColor { UIColor(named: "red") ?? UIColor.red }
    static var YPGray: UIColor { UIColor(named: "gray") ?? UIColor.gray }
    static var YPLightGray: UIColor { UIColor(named: "YPLightGray") ?? UIColor.gray }
    static var YPBackgroundDay: UIColor { UIColor(named: "YPBackgroundDay") ?? UIColor.gray }
}
