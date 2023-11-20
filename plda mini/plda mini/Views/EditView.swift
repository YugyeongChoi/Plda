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
    @State private var isPlayListPresented = false
    @State private var isButtonPresented = false
    
    @State var showingAlert: Bool = false
    
    
    
    var body: some View {
        
        ZStack{
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0)
            {
                TextField("제목", text: $draftDiary.title)
                    .padding(.horizontal, 20)
                    .font(.semiBold)
                
                HStack{
                    Spacer()
                    Text("20230727")
                        .font(.medium12)
                        .padding(.trailing, 30)
                        .padding(.bottom,5)
                }
                .opacity(0.8)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray60)
                    .padding(.horizontal, 20)
                
                TextEditor(text: $draftDiary.content)
                    .padding(.horizontal, 20)
                    .scrollContentBackground(.hidden)
                    .font(.medium16)
                    .padding(.bottom,30)
                
                if(isButtonPresented){
                    VStack(spacing:12){
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
                            isPlayListPresented = true
                        },
                               label: {
                                HStack{
                                    Spacer()
                                    Text("노래 들을 준비 완료!")
                                        .font(.bold16)
                                        .foregroundColor(Color.white)
                                        .padding(.vertical,9)
                                    Spacer()
                                }
                                .background(Color.darkGreen)
                                .cornerRadius(12)
                                .padding(.horizontal,20)
                        })
                        
                        Button(action: {
                            isButtonPresented = false
                        },
                               label: {
                            HStack{
                                Spacer()
                                Text("조금 더 작성할래요.")
                                    .font(.bold16)
                                    .foregroundColor(Color.gray80)
                                    .padding(.vertical,9)
                                Spacer()
                            }
                            .background(Color.gray10)
                            .cornerRadius(12)
                            .padding(.horizontal,20)
                        })
                    }
                }
                
            }
        } //ZStack
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Text("WRITING")
                .font(.semiBold)
                .multilineTextAlignment(.leading)
                .foregroundColor(.darkGreen))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button (action: {
                    showingAlert = true
                }, label: {
                    Image("left")
                })
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("잠깐! 지금 나가면 일기가 저장되지 않아요."),
                        message: Text("그래도 나갈까요?"),
                        primaryButton: .destructive(Text("네, 나갈게요."), action: {path.stack.removeLast()}),
                        secondaryButton: .cancel(Text("아니요, 더 작성할래요.")))
                }
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isButtonPresented.toggle()
                }, label: {
                    Image("playlist")
                })
            }
        }
        .navigationDestination(isPresented: $isPlayListPresented){
            ResultView(result: draftDiary.youtubeData)
        }
        
    }
}

//#Preview {
//    EditView()
//        .environment(Path())
//        .environment(DiaryStore())
//}
//
