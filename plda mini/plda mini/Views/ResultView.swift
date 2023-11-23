//
//  ResultView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct ResultView: View {
    @Environment(Path.self) var path
    @Environment(\.presentationMode) var presentationMode

    var result: YoutubeData?
    
    var body: some View {
        VStack{
            HStack(spacing: 0){
                Image("wave_left")
                    .padding(.trailing,7)
                
                Text("오늘의")
                    .font(.bold24)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Text(" 플다 pick")
                    .font(.bold24)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.darkGreen)
                
                Image("wave_right")
                    .padding(.leading,7)
                
            }
            Spacer()
            Text("Ice Cream Cake")
                .foregroundColor(.black)
                .font(.bold16)
                .padding(.top,45)
            
            Text("Red Velvet (레드벨벳)")
                .foregroundColor(.black)
                .font(.medium12)
            
            if let result = result {
                VStack {
                    Text(result.youtubeDataList[0].tumbnailUrl)
                    Text(result.youtubeDataList[0].title)
                    Text(result.youtubeDataList[0].videoId)
                    Divider()
                    Text(result.youtubeDataList[1].tumbnailUrl)
                    Text(result.youtubeDataList[1].title)
                    Text(result.youtubeDataList[1].videoId)
                    Divider()
                    Text(result.youtubeDataList[2].tumbnailUrl)
                    Text(result.youtubeDataList[2].title)
                    Text(result.youtubeDataList[2].videoId)
                }
            }
            
            Image("heart_gray")
                .padding(.top,14)
            
            NavigationLink(destination: PlaylistView(),
            label:{
                HStack{
                    Text("playlist 확인하러 가기")
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
                .padding(.top,10)
            })
            
            HStack{
                Image("good")
                    .padding(.leading,40)
                Spacer()
                Image("play")
                Spacer()
                Image("bad")
                    .padding(.trailing,40)
                
            }.padding(.top,100)
            Spacer()
        }
        .background(Image("background2"))
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    path.stack.removeLast()
                } label: {
                    HStack {
                        Image("home")
                    }
                }
            }
        }
    }
}


#Preview {
    ResultView(result: YoutubeData(youtubeDataList: [Video(videoId: "12345", tumbnailUrl: "12345", title: "12345")]))
}
