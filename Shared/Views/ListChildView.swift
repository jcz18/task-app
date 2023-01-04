//
//  ListChildView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListChildView: View {
    
    var item: Task
    
    var body: some View {
        NavigationLink(destination:  EditTaskView(taskToEdit: item)) {
            Text(item.name)
        }
    }
}

struct ListChildView_Previews: PreviewProvider {
    static var previews: some View {
        ListChildView(item: Task(name: "help"))
    }
}
