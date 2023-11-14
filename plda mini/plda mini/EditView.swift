//
//  EditView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct EditView: View {
    
    @State private var draftDiary: Diary = Diary(title: "", content: "")
    @Environment(Path.self) var path
    @Environment(DiaryStore.self) var diaryStore
    @State private var isPresented = false

    var body: some View {
        List {
            TextField("제목", text: $draftDiary.title)
            
            TextEditor(text: $draftDiary.content)
        }
        .navigationTitle("일기 작성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    Task {
                        do {
                            guard let response = try await requestPost(text: draftDiary.content) else {
                                throw PostErr.decodeError
                            }
                            draftDiary.youtubeDataListUpdate(list: response)
                            diaryStore.append(diary: draftDiary)
                        }
                        catch {
                            print("fail")
                        }
                        
                    }
                    isPresented = true
                }, label: {
                    Text("저장")
                })
            }
        }
        .navigationDestination(isPresented: $isPresented){
            ResultView(result: draftDiary.youtubeData)
        }
    }
}

#Preview {
    EditView()
        .environment(Path())
        .environment(DiaryStore())
}

