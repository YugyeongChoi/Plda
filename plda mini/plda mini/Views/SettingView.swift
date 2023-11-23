//
//  SettingView.swift
//  Plda
//
//  Created by 최유경 on 2023/08/09.
//

import SwiftUI

struct SettingView: View {
    @Environment(Path.self) var path
    @Environment(DiaryStore.self) var diaryStore
    
    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                Image("play")
                    .padding(.horizontal,40)
                    .padding(.bottom,12)
                
                HStack(spacing : 0){
                    Spacer()
                    Text("닉네임")
                        .font(.bold16)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: EditsettingView()) {
                        Image("right")
                    }
                    Spacer()
                }
                Spacer()
                
                Divider()
                    .padding(.top,0)
                    .padding(.horizontal,20)
                HStack{
                    Text("약관 및 이용 동의")
                        .font(.bold16)
                        .foregroundColor(.gray80)
                    Spacer()
                    Image("right")
                    
                }.padding(.horizontal,25)
                HStack{
                    Text("개인정보 취급 방침")
                        .font(.bold16)
                        .foregroundColor(.gray80)
                    Spacer()
                    Image("right")
                    
                }.padding(.horizontal,25)
                
                Divider()
                    .padding(.top,0)
                    .padding(.horizontal,20)
                
                Spacer()
            }
            .background(Image("background2"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Text("MY")
                        .font(.bold24)
                        .foregroundColor(.darkGreen)
                        .accessibilityAddTraits(.isHeader)
                }
        )
    }
    
}

