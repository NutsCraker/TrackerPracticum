//
//  TrackType.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 15.05.2023.
//

import Foundation
struct TrackerCategory {
    let nameCategory: String
    let trackers: [Tracker]
    
    func visibleTrackers(filterString: String) -> [Tracker] {
        if filterString.isEmpty {
            return trackers
        } else {
            return trackers.filter { $0.name.lowercased().contains(filterString.lowercased()) }
        }
    }
}
