//
//  ContentView.swift
//  Shared
//
//  Created by Jonathan Zhang on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var taskList: [Task]
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: () -> Void
    
    // Trigger alert on top of next hour
    var notificationTrigger: UNCalendarNotificationTrigger? {
        guard let date = Calendar.current.date(byAdding: .hour, value: 1, to: .now) else {
            return nil
        }
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    }
    
    var body: some View {
        VStack {
            ListView(taskList: $taskList)
            Spacer()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                self.saveAction()
                for task in self.taskList {
                    if !task.isFinished && !task.isExpired && task.isApproachingDueDate {
                        let identifier = UUID().uuidString
                        let request = UNNotificationRequest(identifier: identifier, content: task.toNotification(), trigger: self.notificationTrigger)
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            } else if phase == .active {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    struct ContentViewPreviewHolder: View {
        
        @State var taskList: [Task] = []
        
        var body: some View {
            ContentView(taskList: $taskList) {
                
            }
        }
        
    }
    
    static var previews: some View {
        ContentViewPreviewHolder()
    }
}
