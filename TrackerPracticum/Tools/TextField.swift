//
//  TextField.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

final class TextField: UISearchTextField {
    
    func setUpTextField() {
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.YPBackgroundDay.cgColor
        textColor = .YPBlackDay
        clearButtonMode = .whileEditing
        placeholder = "Искать"
        font = UIFont.systemFont(ofSize: 17)
    }
}
