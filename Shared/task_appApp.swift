//
//  task_appApp.swift
//  Shared
//
//  Created by Jonathan Zhang on 1/3/23.
//

import SwiftUI

@main
struct task_appApp: App {
    
    @StateObject var taskStore = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(taskList: $taskStore.taskList) {
                TaskStore.save(tasks: taskStore.taskList) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .onAppear {
                TaskStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let taskList):
                        taskStore.taskList = taskList
                    }
                }
            }
        }
        
    }
}
