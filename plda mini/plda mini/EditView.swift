//
//  EditView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct EditView: View {
    
    private var diary : Diary? = nil
    @State private var title : String = ""
    @State private var content : String = ""
    @Environment(Path.self) var path

    var body: some View {
        VStack {
            TextEditor(text: $title)
            TextEditor(text: $content)
            Spacer()
        }
        .navigationTitle("일기 작성")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    path.stack.removeLast()
                    
                }, label: {
                    Text("저장")
                })
            }
        }
    }
}

#Preview {
    EditView()
}
