//
//  EditTaskView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct EditTaskView: View {
    
    @Binding var taskToEdit: Task
    
    @Binding var taskList: [Task]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 35.0) {
            // Name, Location, isRecurring
            HStack(spacing: 95.0) {
                VStack(alignment: .leading, spacing: 5.0) {
                    LabeledTextField(label: "Name", text: $taskToEdit.name)
                    LabeledTextField(label: "Location", text: $taskToEdit.location)
                }
                LabeledCheckButton(label: "Recurring?", checked: $taskToEdit.isRecurring)
            }
            // EndDate, StartDate, Occurance Rate
            VStack(spacing: 0) {
                Text("Duration and Occurance Rate")
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
                    HStack(spacing: 200.0) {
                        Text("Rate")
                        .frame(maxWidth: .infinity, alignment:.leading)
                        Picker("", selection: $taskToEdit.taskRate) {
                            Text("Daily").tag(Task.Recurrence.daily)
                            Text("Weekly").tag(Task.Recurrence.weekly)
                            Text("Monthly").tag(Task.Recurrence.monthly)
                        }
                        .labelsHidden()
                    }
                    .scaleEffect(0.9)
                    
                }
                .border(.black)
                .frame(width: 305.0, height: 100.0, alignment: .center)
            }
            .disabled(!taskToEdit.isRecurring)
            
            // Description
            VStack(spacing: 0.0) {
                Text("Description")
                    .frame(width: 305.0, height: 15.5, alignment: .bottomLeading)
                .font(.caption)
                TextField("", text: $taskToEdit.description)
                .frame(width: 305.0, height: 180, alignment: .topLeading)
                .padding(EdgeInsets(top: 5.0, leading: 3, bottom: 5.0, trailing: 3))
                .border(.black, width: 1.0)
                
            }
            HStack {
                
                Button("Delete Task") {
                    guard let index = taskList.firstIndex(of: taskToEdit) else {
                        return
                    }
                    taskList.remove(at: index)
                    self.dismiss()
                }
                .buttonStyle(.bordered)
                
                Button( "Edit Task") {
                    guard let index = taskList.firstIndex(of: taskToEdit) else {
                        return
                    }
                    taskList[index] = taskToEdit
                    self.dismiss()
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
        .frame(alignment: .top)
        .navigationBarTitle(taskToEdit.name == "" ? "New Task" : taskToEdit.name, displayMode: .inline)
        .toolbar{
            Button("Complete") {
                taskToEdit.isComplete = true
                self.dismiss()
            }
        }
    }
}


struct EditTaskView_Previews: PreviewProvider {
    
    struct EditTaskViewPreviewHolder: View {
        
        @State var testTask: Task = {
            var _task = Task(name: "help")
            _task.description = "stuff"
            _task.endDate = .distantPast
            return _task
        }()
        
        @State var taskList: [Task] = []
        
        var body: some View {
            EditTaskView(taskToEdit: $testTask, taskList: $taskList)
        }
        
    }
    
    static var previews: some View {
        EditTaskViewPreviewHolder()
    }
}
