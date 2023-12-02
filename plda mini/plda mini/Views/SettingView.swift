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
    @Environment(Profile.self) var profile

    @State var setting: [String] = ["알림 관리", "언어", "업데이트 정보", "약관 및 이용동의", "개인정보 취급 방침"]

    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                profile.userProfileImage
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .padding(.horizontal,40)
                    .padding(.bottom,12)
                
                HStack(spacing : 0){
                    Spacer()
                    Text(profile.username)
                        .font(.bold16)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: EditsettingView()) {
                        Image("right")
                    }
                    Spacer()
                }
                .padding(.bottom,27)

                VStack{
                    Text("플다와 12일을 함께 보냈어요!")
                        .font(.bold16)
                        .foregroundStyle(Color.white)
                        .padding(.top,20)
                    HStack{
                        VStack{
                            Image("prefer")
                                .padding(.top,14)
                            Text("선호 장르")
                                .font(.medium12)
                                .foregroundStyle(Color.black)
                                .padding(.horizontal,18)
                                .padding(.bottom,8)
                        }
                        .padding(.horizontal,11)
                        .background(Color.white)
                        .cornerRadius(12)
                        VStack{
                            Image("month")
                                .padding(.top,14)

                            Text("월별 플다")
                                .font(.medium12)
                                .foregroundStyle(Color.black)
                                .padding(.horizontal,18)
                                .padding(.bottom,8)

                        }
                        .padding(.horizontal,11)
                        .background(Color.white)
                        .cornerRadius(12)
                        VStack{
                            Image("notification")
                                .padding(.top,14)

                            Text("공지사항")
                                .font(.medium12)
                                .foregroundStyle(Color.black)
                                .padding(.horizontal,18)
                                .padding(.bottom,8)

                        }
                        .padding(.horizontal,11)
                        .background(Color.white)
                        .cornerRadius(12)
                        
                    }
                    .padding(.all,12)
                }
                .background(Color.darkGreen)
                .cornerRadius(12)
                .padding(.horizontal,20)

                Spacer()
                
                Divider()
                    .padding(.top,0)
                    .padding(.horizontal,20)
                ForEach(setting, id: \.self) { index in
                    HStack{
                        Text(index)
                            .font(.bold16)
                            .foregroundColor(.gray80)
                        Spacer()
                        Image("right")
                        
                    }.padding(.horizontal,25)
                }
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

