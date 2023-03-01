//
//  ListChildView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListChildView: View {
    
    let dateFormatter: DateFormatter = {
        let _formatter = DateFormatter()
        _formatter.locale = Locale(identifier: "en_US_POSIX")
        _formatter.dateStyle = .short
        return _formatter
    }()
    
    @Binding var item: Task
    
    @Binding var taskList: [Task]
    
    var body: some View {
        NavigationLink(destination:  EditTaskView(taskToEdit: $item, taskList: $taskList)) {
            HStack {
                Text(self.item.name)
                .font(.headline)
                Text(self.item.endDate != .distantFuture ? dateFormatter.string(from: self.item.endDate) : "")
                .font(.caption)
                Spacer()
                if item.isComplete {
                    Image(systemName: "checkmark")
                } else {
                    Image(systemName: "exclamationmark")
                }
                
            }
        }
    }
}

struct ListChildView_Previews: PreviewProvider {
    
    struct ListChildViewPreviewHolder: View {
        
        @State var testTask: Task = {
            var _task = Task(name: "help")
            _task.description = "stuff"
            _task.endDate = .distantPast
            return _task
        }()
        
        @State var testList: [Task] = []
        
        var body: some View {
            ListChildView(item: $testTask, taskList: $testList)
        }
    }
    
    static var previews: some View {
        ListChildViewPreviewHolder()
    }
}
