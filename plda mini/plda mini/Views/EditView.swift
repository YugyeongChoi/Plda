//
//  EditView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct EditView: View {
    @Environment(Path.self) var path

    @State private var draftDiary: Diary = Diary(title: "", content: "")
    @Environment(DiaryStore.self) var diaryStore

    @State private var isPlayListPresented = false
    @State private var isButtonPresented = false
    @State private var showingAlert: Bool = false
    @State private var isPromptSelectionPresented: Bool = false
    
    @State private var prompts: [Prompt] = .init()
    @State private var promptID: Int = 1;
    
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
                    
                    DatePicker("editDate", selection: $draftDiary.editDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .padding(.trailing, 20)
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
                            isPromptSelectionPresented = true
                            
                            Task {
                                do {
                                    let response = try await requestGetPrompts()
                                    
                                    prompts = response
                                }
                                catch {
                                    print("fail")
                                }
                            }
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
        .sheet(isPresented: $isPromptSelectionPresented){
            NavigationStack {
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.darkGreen)
                        .ignoresSafeArea()
                        .offset(y:60)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .ignoresSafeArea()
                        .offset(y:100)
                    VStack {
                        Spacer()
                        Text("🍀 어떤 노래를 추천 받고 싶나요?")
                            .font(.bold16)
                            .padding(.vertical, 10)
                        
                        Button {
                            promptID = 1
                            
                        } label: {
                            HStack{
                                Image(systemName: "applepencil.and.scribble")
                                if (prompts.count > 0) {
                                    Text(prompts[0].prompt)
                                        .font(.medium16)
                                }
                            }
                        }
                        .buttonStyle(InsetRoundButton(labelColor: .white, backgroundColor: promptID == 1 ? Color.lightGreen : Color.gray60))
                        .padding(.vertical, 10)
                        
                        Button {
                            
                            promptID = 2
                            
                        } label: {
                            HStack{
                                Image(systemName: "applepencil.and.scribble")
                                if (prompts.count > 0) {
                                    Text(prompts[1].prompt)
                                        .font(.medium16)
                                    
                                }
                            }
                        }
                        .buttonStyle(InsetRoundButton(labelColor: .white, backgroundColor: promptID == 2 ? Color.lightGreen : Color.gray60))
                        .padding(.vertical, 10)
                        
                        Button {
                            
                            promptID = 3
                            
                        } label: {
                            HStack{
                                Image(systemName: "applepencil.and.scribble")
                                
                                if (prompts.count > 0) {
                                    Text(prompts[2].prompt)
                                        .font(.medium16)
                                    
                                }
                            }
                        }
                        .buttonStyle(InsetRoundButton(labelColor: .white, backgroundColor: promptID == 3 ? Color.lightGreen : Color.gray60))
                        .padding(.vertical, 10)
                        
                        Button(action: {
                            isPromptSelectionPresented = false
                            
                            Task {
                                do {
                                    guard let response = try await requestPost(text: draftDiary.content, prompt: promptID) else {
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
                        }, label:{
                                HStack{
                                    Text("노래 추천받으러 가기")
                                        .font(.medium12)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                        .padding(.horizontal,25)
                                        .padding(.vertical,10)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.lightGreen, lineWidth: 2)
                                )
                                .padding(.vertical,10)
                        })
                        
                    }
                
                }
            }
            .presentationDetents([.height(470)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Text("WRITING")
                .font(.bold24)
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
            ResultView(prompts_id: promptID, result: draftDiary.youtubeData)
        }
        
    }
}

struct InsetRoundButton: ButtonStyle {
  var labelColor = Color.white
  var backgroundColor = Color.blue
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(labelColor)
      .frame(width: 370)
      .padding(.vertical, 10)
      .background(Capsule().fill(backgroundColor))
  }
}
