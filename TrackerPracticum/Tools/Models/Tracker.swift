//
//  Tracker.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 15.05.2023.
//

import UIKit
struct Tracker {
    let id:UUID
    let name: String
    let emoji: String
    let color: UIColor
    let schedule: [DayOfWeek]?
}

struct TrackerRecord {
    let id: UUID
    let date: Date
}
