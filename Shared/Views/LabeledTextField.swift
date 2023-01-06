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
        VStack(spacing: 0.0) {
            Text(label)
            .frame(width: 125.0, height: 15.5, alignment: .bottomLeading)
            .font(.caption)
            TextField("", text: $text)
            .frame(width: 125.0, height: 27.5, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
            .border(.black, width: 1.0)
            
        }
        
        
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField(label: "label", text: "text")
    }
}
