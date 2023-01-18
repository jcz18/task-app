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
    
    public let startDate: Date
    
    public var endDate: Date
    
    public var location: String
    
    public var taskRate: Task.Recurrence
    
    public let id: UUID
    
    public var resetDate: Date
    
    public var isFinished: Bool { self.isComplete && self.resetDate >= self.endDate }
    

    
    /// Class Initializer

    public init(name: String, description: String, isRecurring: Bool, isComplete: Bool, startDate: Date, endDate: Date, location: String, taskRate: Task.Recurrence) {
        self.name = name
        self.description = description
        self.isRecurring = isRecurring
        self.isComplete = isComplete
        self.startDate = startDate
        self.resetDate = startDate
        self.endDate = endDate
        self.location = location
        self.taskRate = taskRate
        self.id = UUID()
    }
    
    public init(name: String) {
        self.init(name: name, description: "", isRecurring: false, isComplete: false, startDate: .now, endDate: .now, location: "", taskRate: .singleton)
    }
    
    /// Class Methods
    
    
    public func equalTo(rhs: Task) -> Bool {
        return self.id == rhs.id
    }
    
    // Reset isComplete, resetDate
    public mutating func resetTask() {
        self.isComplete = false
        if let newDate = self.calculateReset() {
            self.resetDate = newDate
        }
    }
    
    public static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.equalTo(rhs: rhs)
    }
    
    // Calculates the next reset date
    private func calculateReset() -> Date? {
        switch self.taskRate {
        case .singleton:
            return nil
        case .daily:
            return Calendar.current.date(byAdding: .day, value: 1, to: self.resetDate)
        case .weekly:
            return Calendar.current.date(byAdding: .day, value: 7, to: self.resetDate)
        case .monthly:
            return Calendar.current.date(byAdding: .month, value: 1, to: self.resetDate)
        }
    }
    
    
    /// Related Enums
    
    public enum Recurrence: String, Codable {
        case singleton = "only once"
        case daily = "once per day"
        case weekly = "once per week"
        case monthly = "once per month"
    }
}
