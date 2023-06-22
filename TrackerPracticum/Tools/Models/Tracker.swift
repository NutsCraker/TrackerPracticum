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
    let pinned: Bool?
    var category: TrackerCategory? {
        return TrackerCategoryStore().category(forTracker: self)
    }
    //let date: Date?
//
    
}

struct TrackerRecord {
    let id: UUID
    let date: Date
}
struct TrackerCategory {
    let name: String
    let trackers: [Tracker]
    
    func visibleTrackers(filterString: String, pin: Bool?) -> [Tracker] {
        if filterString.isEmpty {
            return pin == nil ? trackers : trackers.filter { $0.pinned == pin }
        } else {
            return pin == nil ? trackers
                .filter { $0.name.lowercased().contains(filterString.lowercased()) }
            : trackers
                .filter { $0.name.lowercased().contains(filterString.lowercased()) }
                .filter { $0.pinned == pin }
                
        }
    }
}

