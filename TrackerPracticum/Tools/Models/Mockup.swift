//
//  Mockup.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 29.05.2023.
//
import UIKit
final class MockData {
    static var categories: [TrackerCategory] = [
        TrackerCategory(nameCategory: "Важное", trackers: [
            Tracker(id: UUID(), name: "Полить цветы", emoji: "🏝", color: .YPBlue, schedule: [.wednesday, .saturday]),
            Tracker(id: UUID(), name: "Помыть посуду", emoji: "🙂", color: .YPRed, schedule: [.monday, .saturday, .wednesday, .friday, .sunday, .thursday,.tuesday])
        ]),
        TrackerCategory(nameCategory: "Тренировки", trackers: [
            Tracker(id: UUID(), name: "Зарядка", emoji: "🤸‍♂️", color: .YPBlue, schedule: [.monday, .wednesday, .friday]),
            Tracker(id: UUID(), name: "Бассейн", emoji: "🏊‍♀️", color: .CS11, schedule: [.tuesday, .thursday, .saturday]),
            Tracker(id: UUID(), name: "Бег", emoji: "🏃‍♂️", color: .CS12, schedule: [.wednesday, .saturday]),
            Tracker(id: UUID(), name: "Зарядка", emoji: "🤸‍♂️", color: .CS07, schedule: [.monday, .wednesday, .saturday])
    ])]
}
