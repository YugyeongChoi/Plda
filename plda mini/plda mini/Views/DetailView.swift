//
//  DiaryView.swift
//  Plda mini
//
//  Created by 최유경 on 11/23/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(Path.self) var path
    @Environment(DiaryStore.self) var diaryStore
    var diary: Diary
    
    @State private var isBottemSheetOpened = false

    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment:.leading, spacing: 0)
            {
                HStack{
                    Text(diary.title)
                        .padding(.horizontal, 20)
                        .font(.semiBold)
                    
                    Spacer()
                }
                
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
                    .padding(.bottom,10)
                VStack(alignment:.leading){
                    Text(diary.content)
                        .padding(.horizontal, 20)
                        .scrollContentBackground(.hidden)
                        .font(.medium16)
                        .padding(.bottom,30)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: {
                            path.stack.removeLast()
                        }) {
                            Image("left")
                                .frame(width: 20, height: 18)
                        }
                        Text("DIARY")
                            .font(.bold24)
                            .multilineTextAlignment(.center)
                        .foregroundColor(.darkGreen)}
                
                ,trailing:
                    Button(action: {
                        isBottemSheetOpened.toggle()
                }) {
                    Image("playlist")
                        .frame(width: 20, height: 18)
                })
            .sheet(isPresented: $isBottemSheetOpened)
            {
                ZStack{                    
                    BottomsheetView()
                        .presentationDetents([.medium,.large])
                        .presentationDragIndicator(.hidden)
                }
            }

        }
    }
}
