//
//  CreateTracker.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

final class NewTrackerViewController: UIViewController {
    private let headerLabel = UILabel()
    private let habitButton = UIButton()
    private let unregularEventButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
}

extension NewTrackerViewController {
    func makeUI() {
        view.backgroundColor = .YPWhite
        
        let allUIElements = [headerLabel, habitButton, unregularEventButton]
        allUIElements.forEach({view.addSubview($0)})
        allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        headerLabel.text = "Создание трекера"
        headerLabel.textColor = .YPBlack
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        
        habitButton.backgroundColor = .YPBlack
        habitButton.setTitle("Привычка", for: .normal)
        habitButton.setTitleColor(.YPWhite, for: .normal)
        habitButton.layer.cornerRadius = 16
        habitButton.addTarget(self, action: #selector(createHabit), for: .touchUpInside)
        
        unregularEventButton.backgroundColor = .YPBlack
        unregularEventButton.setTitle("Нерегулярное событие", for: .normal)
        unregularEventButton.setTitleColor(.YPWhite, for: .normal)
        unregularEventButton.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 295),
            habitButton.widthAnchor.constraint(equalToConstant: 335),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            unregularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            unregularEventButton.centerXAnchor.constraint(equalTo: habitButton.centerXAnchor),
            unregularEventButton.widthAnchor.constraint(equalToConstant: 335),
            unregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    func createHabit() {
        let createHabit = HabitViewController()
        present(createHabit, animated: true)
    }
}

