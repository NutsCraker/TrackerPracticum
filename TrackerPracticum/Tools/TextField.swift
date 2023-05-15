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
        layer.backgroundColor = UIColor.YPBackgroundDay.cgColor
        textColor = .YPBlackDay
        clearButtonMode = .whileEditing
        placeholder = "Поиск"
        font = UIFont.systemFont(ofSize: 17)
    }
    
    func setUpTextFieldOnCreateTracker() {
        layer.cornerRadius = 10
        leftView = nil
        layer.backgroundColor = UIColor.YPBackgroundDay.cgColor
        textColor = .YPBlackDay
        clearButtonMode = .whileEditing
        placeholder = "Введите название трекера"
        font = UIFont.systemFont(ofSize: 17)
    }
}
