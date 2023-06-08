//
//  TrackerRecordStore.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 31.05.2023.
//

import Foundation
import CoreData

final class TrackerRecordStore {
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = DatabaseManager.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addNewTrackerRecord(_ trackerRecord: TrackerRecord) throws {
        let trackerRecordCoreData = TrackerRecordCoreData(context: context)
        updateExistingTrackerRecord(trackerRecordCoreData, with: trackerRecord)
        try context.save()
    }
    
    func deleteTrackerRecord(with id: UUID) throws {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        let trackerRecordFromCoreData = try context.fetch(fetchRequest)
        let record = trackerRecordFromCoreData.first {
            $0.id == id
        }
        if let record = record {
            context.delete(record)
            try context.save()
        }
    }
    
    func updateExistingTrackerRecord(_ trackerRecordCoreData: TrackerRecordCoreData, with record: TrackerRecord) {
        trackerRecordCoreData.id = record.id
        trackerRecordCoreData.date = record.date
    }
    
    func fetchTrackerRecord() throws -> [TrackerRecord] {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        let trackerRecordFromCoreData = try context.fetch(fetchRequest)
        return try trackerRecordFromCoreData.map { try self.trackerRecord(from: $0) }
    }
    
    func trackerRecord(from data: TrackerRecordCoreData) throws -> TrackerRecord {
        guard let id = data.id else {
            throw DatabaseError.someError
        }
        guard let date = data.date else {
            throw DatabaseError.someError
        }
        return TrackerRecord(
            id: id,
            date: date
        )
    }
}
