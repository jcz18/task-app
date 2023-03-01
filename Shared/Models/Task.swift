//
//  Task.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/3/23.
//

import Foundation
import UserNotifications

public struct Task: Identifiable, Codable, Equatable {
    
    /// Class Variables
    
    public var name: String
    
    public var description: String
    
    public var isRecurring: Bool
    
    public var isComplete: Bool
    
    public let startDate: Date
    
    public var endDate: Date {
        didSet {
            self.resetDate = self.endDate
            if let nextReset = self.calculateReset() {
                self.resetDate = nextReset
            }
        }
    }
    
    public var location: String
    
    public var taskRate: Task.Recurrence
    
    public let id: UUID
    
    /// When the completeness of task should reset, and new reset date calculated. This can be bigger than the end date.
    public var resetDate: Date
    
    public var isFinished: Bool { self.isComplete && self.resetDate >= self.endDate }
    
    /// If task is expired and no longer active.
    public var isExpired: Bool { self.endDate < .now }
    
    /// When the task is due; either the next reset date, or the end date.
    public var dueDate: Date { self.resetDate > self.endDate ? self.endDate : self.resetDate }
    
    /// Calculates if task is about to expire, based on reset date, end date, and task rate
    public var isApproachingDueDate: Bool {
        var notifyDate: Date?
        switch self.taskRate {
        case .daily:
            notifyDate = Calendar.current.date(byAdding: .hour, value: -2, to: self.dueDate)
        case .weekly:
            notifyDate = Calendar.current.date(byAdding: .day, value: -2, to: self.dueDate)
        case .monthly:
            notifyDate = Calendar.current.date(byAdding: .day, value: -7, to: self.dueDate)
        case .singleton:
            notifyDate = Calendar.current.date(byAdding: .day, value: -2, to: self.dueDate)
        }
        return notifyDate ?? .distantPast < .now
    }

    
    /// Class Initializer

    public init(name: String, description: String, isRecurring: Bool, isComplete: Bool, startDate: Date, endDate: Date, location: String, taskRate: Task.Recurrence) {
        self.name = name
        self.description = description
        self.isRecurring = isRecurring
        self.isComplete = isComplete
        self.startDate = startDate
        self.resetDate = endDate
        self.endDate = endDate
        self.location = location
        self.taskRate = taskRate
        self.id = UUID()
    }
    
    public init(name: String) {
        self.init(name: name, description: "", isRecurring: false, isComplete: false, startDate: .now, endDate: .now, location: "", taskRate: .singleton)
    }
    
    /// Class Methods
    
    public func toNotification() -> UNMutableNotificationContent {
        let notification = UNMutableNotificationContent()
        notification.title = "Task App Alert"
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        notification.subtitle = "\(self.name) task due in \(formatter.string(from: .now, to: self.dueDate) ?? "ERR" )."
        notification.sound = .default
        
        return notification
    }
    
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
