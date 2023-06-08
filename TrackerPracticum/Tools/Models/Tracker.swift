//
//  Tracker.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 15.05.2023.
//

import UIKit
struct Tracker: Hashable {
    let id:UUID
    let name: String
    let emoji: String?
    let color: UIColor?
    let schedule: [DayOfWeek]?
    //let date: Date?
}

struct TrackerRecord {
    let id: UUID
    let date: Date
}
struct TrackerCategoryModel {
    let name: String
    let trackers: [Tracker]
    
    func visibleTrackers(filterString: String) -> [Tracker] {
        if filterString.isEmpty {
            return trackers
        } else {
            return trackers.filter { $0.name.lowercased().contains(filterString.lowercased()) }
        }
    }
}

