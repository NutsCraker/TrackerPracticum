//
//  TextField.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

final class TextField: UISearchTextField {
    
    func setUpTextFieldOnTrackerView() {
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.YPBackground.cgColor
        textColor = .YPBlack
        clearButtonMode = .whileEditing
        placeholder = "Поиск"
        font = UIFont.systemFont(ofSize: 17)
    }
    
    func setUpTextFieldOnCreateTracker() {
        layer.cornerRadius = 10
        leftView = nil
        layer.backgroundColor = UIColor.YPBackground.cgColor
        textColor = .YPBlack
        clearButtonMode = .whileEditing
        placeholder = "Введите название трекера"
        font = UIFont.systemFont(ofSize: 17)
    }
}
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension UIFont {
    class func mediumSystemFont(ofSize pointSize: CGFloat) -> UIFont {
        return self.systemFont(ofSize: pointSize, weight: .medium)
    }
}

