//
//  TrackerViewController.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

class TrackerViewController: UIViewController {
    
    private let emptyImage = UIImageView()
    private let emptyLable = UILabel()
    private let header = UILabel()
    private let searchTextField  = TextField()
    private let datePicker = UIDatePicker()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let storage = Storage.shared
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhiteDay
        
        makeUI()
        searchTextField.delegate = self
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: "cellCollection")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TrackerViewController {
    func makeUI() {
        let newTracker1 = Tracker(id: "\(storage.trackers.count + 1)")
        storage.trackers.append(newTracker1)
        
        searchTextField.setUpTextField()
        
        guard let navBar = navigationController?.navigationBar else { return }
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(updateUI))//addTracker))
        let date = UIBarButtonItem(customView: datePicker)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        
        navBar.topItem?.setRightBarButton(date, animated: false)
        navBar.topItem?.setLeftBarButton(addButton, animated: false)
        addButton.tintColor = .YPBlackDay
        addButton.width = 19
        
        if storage.trackers.isEmpty {
            let allUIElements = [emptyImage, emptyLable, header, searchTextField, datePicker]
            allUIElements.forEach({view.addSubview($0)})
            allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
            emptyImage.image = UIImage(named: "emptyTracker")
            
            emptyLable.text = "Что будем отслеживать?"
            emptyLable.font = UIFont.systemFont(ofSize: 12)
            emptyLable.tintColor = .YPBlackDay
            
            header.text = "Трекеры"
            header.font = UIFont.boldSystemFont(ofSize: 34)
            header.tintColor = .YPBlackDay
            
            
            NSLayoutConstraint.activate([
                emptyImage.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 366),
                emptyImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                emptyLable.centerXAnchor.constraint(equalTo: emptyImage.centerXAnchor),
                emptyLable.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
                header.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                header.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                searchTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                searchTextField.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 7),
                searchTextField.heightAnchor.constraint(equalToConstant: 36),
                searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 16*2)
            ])
        } else {
            let allUIElements = [header, searchTextField, datePicker, collectionView]
            allUIElements.forEach({view.addSubview($0)})
            allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})

            
            header.text = "Трекеры"
            header.font = UIFont.boldSystemFont(ofSize: 34)
            header.tintColor = .YPBlackDay
            
            
            NSLayoutConstraint.activate([
                header.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                header.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                searchTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                searchTextField.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 7),
                searchTextField.heightAnchor.constraint(equalToConstant: 36),
                searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 16*2),
                collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50)
            ])
        }
        
//        let allUIElements = [emptyImage, emptyLable, header, searchTextField, datePicker, collectionView]
//        allUIElements.forEach({view.addSubview($0)})
//        allUIElements.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
//        emptyImage.image = UIImage(named: "emptyTracker")
//
//        emptyLable.text = "Что будем отслеживать?"
//        emptyLable.font = UIFont.systemFont(ofSize: 12)
//        emptyLable.tintColor = .YPBlackDay
//
//        header.text = "Трекеры"
//        header.font = UIFont.boldSystemFont(ofSize: 34)
//        header.tintColor = .YPBlackDay
//
//
//        NSLayoutConstraint.activate([
//            emptyImage.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 366),
//            emptyImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            emptyLable.centerXAnchor.constraint(equalTo: emptyImage.centerXAnchor),
//            emptyLable.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
//            header.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            header.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
//            searchTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            searchTextField.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 7),
//            searchTextField.heightAnchor.constraint(equalToConstant: 36),
//            searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 16*2),
//            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50)
//        ])
    }
    @objc
    func updateUI() {
        let newTracker = Tracker(id: "\(storage.trackers.count + 1)")
        let nextIndex = storage.trackers.count
        storage.trackers.append(newTracker)
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [IndexPath(row: nextIndex, section: 0)])
        })
    }
}

extension TrackerViewController {
    @objc
    func addTracker() {
        let createTracker = CreateTracker()
        present(createTracker, animated: true)
            
    }
}

extension TrackerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.searchTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 120).isActive = true
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.searchTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 16*2)
            self.view.layoutIfNeeded()
        }
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as? TrackerCell
       cell?.contentView.backgroundColor = .YPRed
        cell?.textLabel.text = "\(storage.trackers[indexPath.row].id)"
        return cell!
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}


