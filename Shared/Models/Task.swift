//
//  Task.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/3/23.
//

import Foundation

public struct Task: Identifiable, Codable, Equatable {
    
    /// Class Variables
    
    public var name: String
    
    public var description: String
    
    public var isRecurring: Bool
    
    public var isComplete: Bool
    
    public var startDate: Date
    
    public var endDate: Date
    
    public var location: String
    
    public let id: UUID
    
    /// Class Initializer

    public init(name: String, description: String, isRecurring: Bool, isComplete: Bool, startDate: Date, endDate: Date, location: String) {
        self.name = name
        self.description = description
        self.isRecurring = isRecurring
        self.isComplete = isComplete
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.id = UUID()
    }
    
    public init(name: String) {
        self.init(name: name, description: "", isRecurring: false, isComplete: false, startDate: .now, endDate: .distantFuture, location: "")
    }
    
    /// Class Methods
    
    public func equalTo(rhs: Task) -> Bool {
        return self.id == rhs.id
    }
    
    public static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.equalTo(rhs: rhs)
    }
}
