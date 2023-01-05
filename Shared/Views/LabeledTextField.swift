//
//  LabeledTextField.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/5/23.
//

import SwiftUI

struct LabeledTextField: View {
    
    @State var label: String = ""
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(label)
            .frame(width: 125.0, height: 22.5, alignment: .leading)
            TextField("Name", text: $text)
            .frame(width: 125.0, height: 27.5, alignment: .trailing)
            .border(.black, width: 1.0)
            
        }
        
        
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField(label: "label", text: "text")
    }
}
