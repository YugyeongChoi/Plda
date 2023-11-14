//
//  MainView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct MainView: View {
    @Environment(DiaryStore.self) var diaryStore
    @Environment(Path.self) var path
    
    var body: some View {
        @Bindable var path = path
        
        NavigationStack (path: $path.stack){
            List(diaryStore.list, id: \.id) { diary in
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
        .environment(Path())
        .environment(DiaryStore())
}
