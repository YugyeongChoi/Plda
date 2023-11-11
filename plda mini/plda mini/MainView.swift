//
//  MainView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct MainView: View {
    @Environment(Path.self) var path : Path
    
    var body: some View {
        @Bindable var path = path
        
        NavigationStack (path: $path.stack){
            List(diaries, id: \.id) { diary in
                Text(diary.title)
            }
            .navigationTitle("Main")
            .toolbar {
                ToolbarItemGroup (placement: .topBarTrailing) {
                    NavigationLink("Edit", value: 1)
                }
            }
            .navigationDestination(for: Int.self) { x in
                EditView()
            }
        }
    }
}

#Preview {
    MainView()
}
