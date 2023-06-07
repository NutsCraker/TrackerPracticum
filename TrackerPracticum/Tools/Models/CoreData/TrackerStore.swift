//
//  TrackerStore.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 31.05.2023.
//

import Foundation
import CoreData

final class TrackerStore {
    
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = DatabaseManager.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchTrackers() throws -> [Tracker] {
        let fetchRequest = TrackerCoreData.fetchRequest()
        let trackersFromCoreData = try context.fetch(fetchRequest)
        return try trackersFromCoreData.map { try self.tracker(from: $0) }
    }
    
    func addNewTracker(_ tracker: Tracker) throws {
        let trackerCoreData = TrackerCoreData(context: context)
        updateExistingTracker(trackerCoreData, with: tracker)
        try context.save()
    }
    
    func updateExistingTracker(_ trackerCoreData: TrackerCoreData, with tracker: Tracker) {
        trackerCoreData.nameTracker = tracker.name
        trackerCoreData.id = tracker.id
        trackerCoreData.emoji = tracker.emoji
        trackerCoreData.schedule = tracker.schedule?.compactMap { $0.rawValue }
        trackerCoreData.color = tracker.color?.hexString
       // trackerCoreData.date = tracker.date
    }
    
 
    func tracker(from data: TrackerCoreData) throws -> Tracker {
        guard let name = data.nameTracker else {
            throw DatabaseError.someError
        }
        guard let uuid = data.id else {
            throw DatabaseError.someError
        }
        guard let emoji = data.emoji else {
            throw DatabaseError.someError
        }
        guard let schedule = data.schedule else {
            throw DatabaseError.someError
        }
        guard let color = data.color else {
            throw DatabaseError.someError
        }
        return Tracker(
            id: uuid,
            name: name,
            emoji: emoji, color: color.color,
            schedule: schedule.compactMap {DayOfWeek(rawValue: $0) }
          
        )
    }
}
