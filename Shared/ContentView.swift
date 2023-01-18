//
//  ContentView.swift
//  Shared
//
//  Created by Jonathan Zhang on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var taskList: [Task]
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: () -> Void
    
    var body: some View {
        VStack {
            ListView(taskList: $taskList)
            Spacer()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                self.saveAction()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    struct ContentViewPreviewHolder: View {
        
        @State var taskList: [Task] = []
        
        var body: some View {
            ContentView(taskList: $taskList) {
                
            }
        }
        
    }
    
    static var previews: some View {
        ContentViewPreviewHolder()
    }
}
