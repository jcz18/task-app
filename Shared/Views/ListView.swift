//
//  ListView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListView: View {
    
    @Binding var taskList: [Task]
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            List($taskList) { $task in
                ListChildView(item: $task, taskList: $taskList)
            }
            .toolbar{
                Image(systemName: "plus")
                .onTapGesture {
                    taskList.append(Task(name: "New Task"))
                }
                
            }
            .navigationTitle("Task App")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onReceive(timer) { alert in
            for index in 0..<taskList.count {
                if taskList[index].resetDate < .now && !taskList[index].isFinished {
                    taskList[index].resetTask()
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    struct ListViewPreviewHolder: View {
        
        @State var list: [Task] = {
            var _task = Task(name: "help")
            _task.description = "stuff"
            _task.endDate = .distantPast
            var _taskTwo = Task(name: "test")
            _taskTwo.description = "wow"
            _taskTwo.endDate = .distantPast
            return [_task, _taskTwo]
        }()
        
        var body: some View {
            ListView(taskList: $list)
        }
    }
    
    static var previews: some View {
        ListViewPreviewHolder()
    }
}
