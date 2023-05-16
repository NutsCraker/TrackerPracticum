//
//  TrackerCell.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit


protocol TrackerCellDelegate: AnyObject {
    func completeTracker(id: UUID, indexPath: IndexPath)
    func uncompleteTracker(id: UUID, indexPath: IndexPath)
}
 
final class TrackerCell: UICollectionViewCell {
    let name = UILabel()
    let emoji = UILabel()
    let backView = UIView()
    let daytext = UILabel()
    let buttonPlus = UIButton()
    private var isCompletedToday: Bool = false
    private var idTracker: UUID?
    private var indexPath: IndexPath?
    
    weak var delegate: TrackerCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let allElementsOnView = [backView ,name, emoji, daytext, buttonPlus]
        allElementsOnView.forEach({contentView.addSubview($0)})
        allElementsOnView.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        backView.layer.cornerRadius = 16
        name.font = UIFont.systemFont(ofSize: 12)
        name.textColor = .YPWhite
        emoji.font = UIFont.systemFont(ofSize: 16)
        daytext.font = UIFont.systemFont(ofSize: 12)
        
        buttonPlus.addTarget(self, action: #selector(completedTracker), for: .touchUpInside)
        buttonPlus.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonPlus.imageView?.tintColor = .YPWhite
        buttonPlus.layer.cornerRadius = 17
        
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46),
            emoji.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            emoji.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            daytext.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 16),
            daytext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            buttonPlus.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 8),
            buttonPlus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            buttonPlus.widthAnchor.constraint(equalToConstant: 34),
            buttonPlus.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    func configTrackerCellButtonUI(tracker: Tracker, isCompleted: Bool, indexPath: IndexPath) {
        self.isCompletedToday = isCompleted
        idTracker = tracker.id
        self.indexPath = indexPath
    }
    
    @objc
    func completedTracker() {
        guard let idTracker = idTracker, let indexPath = indexPath else { return }
        if isCompletedToday {
            
            delegate?.uncompleteTracker(id: idTracker, indexPath: indexPath)
            buttonPlus.setImage(UIImage(systemName: "plus"), for: .normal)
            buttonPlus.imageView?.tintColor = .YPWhite
            buttonPlus.alpha = 1
        } else {
            delegate?.completeTracker(id: idTracker, indexPath: indexPath)
            buttonPlus.setImage(UIImage(named: "done"), for: .normal)
            buttonPlus.alpha = 0.3
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
