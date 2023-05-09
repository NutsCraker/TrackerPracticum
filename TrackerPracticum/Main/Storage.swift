//
//  Storage.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import Foundation

final class Storage {
    
    static let shared = Storage()
    
    var trackers: [Tracker] = []
    
}
