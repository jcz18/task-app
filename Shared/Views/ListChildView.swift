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
    
    @State var item: Task
    
    var body: some View {
        NavigationLink(destination:  EditTaskView(taskToEdit: item)) {
            HStack {
                Text(self.item.name)
                Text(self.item.endDate != .distantFuture ? dateFormatter.string(from: self.item.endDate) : "")
                
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

struct ListChildView_Previews: PreviewProvider {
    static var previews: some View {
        ListChildView(item: task)
    }
}
