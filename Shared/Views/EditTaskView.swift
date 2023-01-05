//
//  EditTaskView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct EditTaskView: View {
    
    @State var taskToEdit: Task = Task(name: "")
    
    var body: some View {
        NavigationView {
        VStack {
            HStack {
                LabeledTextField(label: "Name", text: taskToEdit.name)
                LabeledTextField(label: "Description", text: taskToEdit.description)
            }
            HStack {
                TextField("Location", text: $taskToEdit.location)
                Text("xd")
            }
            HStack {
                DatePicker("Start Date", selection: $taskToEdit.startDate)
                DatePicker("End Date", selection: $taskToEdit.endDate)
            }
        }
        }
        .navigationTitle(taskToEdit.name)

    }
}

private var task: Task = {
    var _task = Task(name: "help")
    _task.description = "stuff"
    _task.endDate = .distantPast
    return _task
}()

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(taskToEdit: task)
    }
}
