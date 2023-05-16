//
//  TrackerViewController.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

final class TrackerViewController: UIViewController {
    
    private let emptyImage = UIImageView()
    private let emptyLable = UILabel()
    private let addTraker = UIButton()
    private let header = UILabel()
    private let searchTextField  = TextField()
    private let datePicker = UIDatePicker()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let storage = Storage.shared
    private var categories = [TrackerType]()
    private var visibleTrackerCategories = [TrackerType]()
    private var completedTracker = [TrackerRecord]()
    private let createHabit = HabitViewController.shared
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        categories = storage.storageTrackerType
        visibleTrackerCategories = categories
        collectionView.register(ViewCategory.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        makeUI()
        searchTextField.delegate = self
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: "cellCollection")
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension TrackerViewController {
    func makeUI() {
        
        searchTextField.setUpTextFieldOnTrackerView()
        
        addTraker.addTarget(self, action: #selector(addTracker), for: .touchUpInside)
        addTraker.setImage(UIImage(systemName: "plus"), for: .normal)
        addTraker.sizeThatFits(CGSize(width: 19, height: 18))
        addTraker.tintColor = .YPBlack
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_Ru")
        datePicker.addTarget(self, action: #selector(dateChanget), for: .valueChanged)
        
        if visibleTrackerCategories.isEmpty {
            let allUIElements = [emptyImage, emptyLable, header, searchTextField, datePicker, addTraker]
            allUIElements.forEach({view.addSubview($0)})
            allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
            emptyImage.image = UIImage(named: "emptyTracker")
            
            emptyLable.text = "Что будем отслеживать?"
            emptyLable.font = UIFont.systemFont(ofSize: 12)
            emptyLable.tintColor = .YPBlack
            
            header.text = "Трекеры"
            header.font = UIFont.boldSystemFont(ofSize: 34)
            header.tintColor = .YPBlack
            
            NSLayoutConstraint.activate([
                addTraker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
                addTraker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
                emptyImage.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 366),
                emptyImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                emptyLable.centerXAnchor.constraint(equalTo: emptyImage.centerXAnchor),
                emptyLable.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
                header.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                header.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                datePicker.bottomAnchor.constraint(equalTo: searchTextField.topAnchor, constant: -11),
                datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                searchTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                searchTextField.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 7),
                searchTextField.heightAnchor.constraint(equalToConstant: 36),
                searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 16*2)
            ])
        } else {
            let allUIElements = [header, searchTextField, datePicker, collectionView, addTraker]
            allUIElements.forEach({view.addSubview($0)})
            allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
            
            header.text = "Трекеры"
            header.font = UIFont.boldSystemFont(ofSize: 34)
            header.tintColor = .YPBlack
            
            NSLayoutConstraint.activate([
                addTraker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
                addTraker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
                header.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                header.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                datePicker.bottomAnchor.constraint(equalTo: searchTextField.topAnchor, constant: -11),
                datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                searchTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                searchTextField.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 7),
                searchTextField.heightAnchor.constraint(equalToConstant: 36),
                searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 16*2),
                collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 34),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50)
            ])
        }
    }
}

extension TrackerViewController {
    @objc
    private func addTracker() {
        let createTracker = NewTrackerViewController()
        present(createTracker, animated: true)
    }
    
    @objc
    private func dateChanget() {
        reloadVisibleCategories()
    }
    
    private func reloadVisibleCategories() {
        let calendar = Calendar.current
        let filterWeekDay = calendar.component(.weekday, from: datePicker.date)
        let filterText = (searchTextField.text ?? "").lowercased()
        visibleTrackerCategories = categories.map { category in
            TrackerType(nameCategory: category.nameCategory, trakers: category.trakers.filter { tracker in
                let textCondition = filterText.isEmpty || tracker.name.lowercased().contains(filterText)
                let dateCondotion = tracker.schedule?.contains { weekDay in
                    weekDay.rawValue + 1 == filterWeekDay
                } == true
                return textCondition && dateCondotion
            }
            )
        }
        collectionView.reloadData()
    }
}

extension TrackerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        reloadVisibleCategories()
        return true
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleTrackerCategories[0].trakers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as? TrackerCell else { return UICollectionViewCell() }
        let tracker = visibleTrackerCategories[0].trakers[indexPath.row]
        let isCompletedToday = isCompletedTrackerToday(id: tracker.id)
        let countDay =  completedTracker.filter { $0.id == tracker.id }.count
        if completedTracker.isEmpty {
            cell.daytext.text = "0 дней"
        } else {
            cell.daytext.text = "\(countDay) дней"
        }
        cell.configTrackerCellButtonUI(tracker: tracker, isCompleted: isCompletedToday, indexPath: indexPath)
        cell.delegate = self
        cell.name.text = "\(visibleTrackerCategories[0].trakers[indexPath.row].name)"
        cell.emoji.text = "\(visibleTrackerCategories[0].trakers[indexPath.row].emoji)"
        cell.backView.backgroundColor = visibleTrackerCategories[0].trakers[indexPath.row].color
        cell.buttonPlus.backgroundColor = visibleTrackerCategories[0].trakers[indexPath.row].color
        return cell
    }
    
    private func isCompletedTrackerToday(id: UUID) -> Bool {
        completedTracker.contains { trackerRecord in
            let sameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: datePicker.date)
            return trackerRecord.id == id && sameDay
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id = "header"
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? ViewCategory
        view?.titleLabel.text = "\(visibleTrackerCategories[indexPath.row].nameCategory)"
        return view!
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

extension TrackerViewController: TrackerCellDelegate {
    func completeTracker(id: UUID, indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: datePicker.date)
        completedTracker.append(trackerRecord)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func uncompleteTracker(id: UUID, indexPath: IndexPath) {
        completedTracker.removeAll { trackerRecord in
            let sameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: datePicker.date)
            return trackerRecord.id == id && sameDay
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
