//
//  EditTaskView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct EditTaskView: View {
    
    @State var taskToEdit: Task = Task(name: "")
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 35.0) {
            // Name, Location, isRecurring
            HStack(spacing: 95.0) {
                VStack(alignment: .leading, spacing: 5.0) {
                    LabeledTextField(label: "Name", text: taskToEdit.name)
                    LabeledTextField(label: "Location", text: taskToEdit.location)
                }
                LabeledCheckButton(label: "Recurring?", checked: taskToEdit.isRecurring)
            }
            // EndDate, StartDate
            VStack(spacing: 5.5) {
                Text("Start and End Date")
                .padding()
                .font(.caption)
                .frame(width: 335.0, height: 25.0, alignment: .bottomLeading)
                VStack {
                    DatePicker("Start", selection: $taskToEdit.startDate)
                    .scaleEffect(0.9)
                    .padding(EdgeInsets(top: 6, leading: 0, bottom: 2, trailing: 0))
                    DatePicker("End", selection: $taskToEdit.endDate)
                    .scaleEffect(0.9)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 6, trailing: 0))
                }
                .border(.black)
                .frame(width: 305.0, height: 50.0, alignment: .center)
            }
            // Description
            VStack(spacing: 0.0) {
                Text("Description")
                    .frame(width: 305.0, height: 15.5, alignment: .bottomLeading)
                .font(.caption)
                TextField("", text: $taskToEdit.description)
                .frame(width: 305.0, height: 200, alignment: .topLeading)
                .padding(EdgeInsets(top: 5.0, leading: 3, bottom: 5.0, trailing: 3))
                .border(.black, width: 1.0)
                
            }
            Button(taskToEdit.name == "" ? "Create Task" : "Edit Task") {
                self.dismiss()
            }
            .buttonStyle(.bordered)
        }
        .frame(alignment: .top)
        .navigationBarTitle(taskToEdit.name == "" ? "New Task" : taskToEdit.name, displayMode: .inline)
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
