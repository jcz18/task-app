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
    
    public static func fileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("taskData.txt")
    }
    
    static func load(completion: @escaping (Result<[Task], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileUrl()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tasks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(tasks: [Task], completion: @escaping (Result<Int, Error>)->Void) {
           DispatchQueue.global(qos: .background).async {
               do {
                   let data = try JSONEncoder().encode(tasks)
                   let outfile = try fileUrl()
                   try data.write(to: outfile)
                   DispatchQueue.main.async {
                       completion(.success(tasks.count))
                   }
               } catch {
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
               }
           }
       }
    
    
    
}
