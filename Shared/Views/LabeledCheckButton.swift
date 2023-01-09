//
//  LabeledCheckButton.swift
//  task-app
//
//  Created by Jonathan Zhang on 1/6/23.
//

import SwiftUI

struct LabeledCheckButton: View {
    
    @State var label: String = ""
    
    @Binding var checked: Bool
    
    
    var body: some View {
        VStack(spacing: 5.0) {
            Text(self.label)
            Image(systemName: self.checked ? "checkmark.square" : "square")
                .foregroundColor(.black)
                .onTapGesture {
                    self.checked.toggle()
                }
        }
    }
}

struct LabeledCheckButton_Previews: PreviewProvider {
    
    struct LabeledCheckButtonPreviewHolder: View {
        
        @State var isChecked = false
        
        var body: some View {
            LabeledCheckButton(label:"test", checked: $isChecked)
        }
        
    }
    
    static var previews: some View {
        LabeledCheckButtonPreviewHolder()
    }
}
