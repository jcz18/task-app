//
//  ListView.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/4/23.
//

import SwiftUI

struct ListView: View {
    
    var list: [Task] = [
        Task(name: "help"),
        Task(name: "test")
    ]
    
    
    var body: some View {
        NavigationView {
            List {
            ForEach(list) { task in
                ListChildView(item: task)
                .toolbar{
                    NavigationLink(destination: EditTaskView()) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
            .navigationTitle("Task App")
        }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
