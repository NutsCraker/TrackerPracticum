//
//  ViewEmodji.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 16.05.2023.
//

import UIKit

class ViewEmoji: UICollectionReusableView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
