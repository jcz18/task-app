//
//  ListView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var list: TaskStore
    
    var body: some View {
        NavigationView {
            List($list.taskList) { $task in
                ListChildView(item: $task, taskList: $list.taskList)
            }
            .toolbar{
                Image(systemName: "plus")
                .onTapGesture {
                    list.taskList.append(Task(name: "New Task"))
                }
            }
            .navigationTitle("Task App")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    struct ListViewPreviewHolder: View {
        
        @ObservedObject var list: TaskStore = {
            var _store = TaskStore()
            var _task = Task(name: "help")
            _task.description = "stuff"
            _task.endDate = .distantPast
            var _taskTwo = Task(name: "test")
            _taskTwo.description = "wow"
            _taskTwo.endDate = .distantPast
            _store.taskList = [_task, _taskTwo]
            return _store
        }()
        
        var body: some View {
            ListView(list: list)
        }
    }
    
    static var previews: some View {
        ListViewPreviewHolder()
    }
}
