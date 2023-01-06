//
//  ListView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListView: View {
    
    var list: [Task]
    
    
    var body: some View {
        NavigationView {
            List {
            ForEach(list) { task in
                ListChildView(item: task)
                .toolbar{
                    NavigationLink(destination: EditTaskView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Task App")
            .navigationBarTitleDisplayMode(.inline)
        }
        }
    }
}

private var task: Task = {
    var _task = Task(name: "help")
    _task.description = "stuff"
    _task.endDate = .distantPast
    return _task
}()

private var taskTwo: Task = {
    var _task = Task(name: "test")
    _task.description = "wow"
    _task.endDate = .distantPast
    return _task
}()

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(list: [task, taskTwo])
    }
}
