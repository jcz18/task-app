//
//  Task.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/3/23.
//

import Foundation

public class Task: Codable, Identifiable {
    
    /// Class Variables
    
    public var name: String
    
    public var description: String
    
    public var isRecurring: Bool
    
    public var isComplete: Bool
    
    public var startDate: Date
    
    public var endDate: Date
    
    public var location: String
    
    /// Class Initializer

    public init(name: String, description: String, isRecurring: Bool, isComplete: Bool, startDate: Date, endDate: Date, location: String) {
        self.name = name
        self.description = description
        self.isRecurring = isRecurring
        self.isComplete = isComplete
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
    }
    
    public convenience init(name: String) {
        self.init(name: name, description: "", isRecurring: false, isComplete: false, startDate: .now, endDate: .distantFuture, location: "")
    }
    
    /// Class Methods
}
