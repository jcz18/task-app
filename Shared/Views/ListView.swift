//
//  ListView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListView: View {
    
    @State var list: [Task]
    
    
    var body: some View {
        NavigationView {
            List($list) { $task in
                ListChildView(item: $task, taskList: $list)
                .toolbar{
                    NavigationLink(destination: EditTaskView(taskToEdit: .constant(Task(name: "")), taskList: $list)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Task App")
            .navigationBarTitleDisplayMode(.inline)
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
