//
//  TaskStore.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/11/23.
//

import Foundation
import SwiftUI

public class TaskStore: ObservableObject {
    
    @Published public var taskList: [Task] = []
    
    
}
