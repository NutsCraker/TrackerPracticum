//
//  HabbitCell.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 16.05.2023.
//

import UIKit

final class HabitCell: UITableViewCell {
    let firstLabel = UILabel()
    let secondLabel = UILabel()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cellCustom")
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        
        firstLabel.font = UIFont.systemFont(ofSize: 17)
        firstLabel.textColor = .YPBlack
        
        secondLabel.font = UIFont.systemFont(ofSize: 17)
        secondLabel.textColor = .YPGray
        
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 2),
            secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

