//
//  Storage.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//
import UIKit

final class Storage {
    
    static let shared = Storage()
    private let uniqueId = UUID()
    var trackers: [Tracker] = []
    var storageTrackerType: [TrackerType] = []
    
    func addNewTracker(name: String, emoji: String, color: UIColor, schedule: [DayOfWeek], category: String) {
    
        let newTracker = Tracker(id: uniqueId, name: name, emoji: emoji, color: color, schedule: schedule)
        if storageTrackerType.isEmpty {
         
            trackers.append(newTracker)
            let newTrackerType = TrackerType(nameCategory: "Важное", trackers: trackers)
            storageTrackerType.append(newTrackerType)
        } else {
            storageTrackerType.removeLast()

            trackers.append(newTracker)
            let newTrackerType = TrackerType(nameCategory: "Важное", trackers: trackers)
            storageTrackerType.append(newTrackerType)
        }
    }
}


