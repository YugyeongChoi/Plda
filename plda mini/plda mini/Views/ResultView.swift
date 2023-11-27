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
            
            pagingView()
            
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
            Spacer()
            
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

struct pagingView: View {
    @State var title: [String] = ["Ice Cream Cake", "손오공", "Drama"]
    @State var heart = [Bool] (repeating: false ,count :3)
    @State var isHeartTapped = false
    
    var body: some View {
        TabView(){
            ForEach(0..<title.count, id: \.self) { index in
                VStack{
                    Spacer()
                    
                    Text(title[index])
                        .foregroundColor(.black)
                        .font(.bold16)
                        .padding(.bottom,18)

                    HStack{
                        Spacer()
                        
                        Button(action: {
                            //유튜브로 이동
                        }, label: {
                            Image("play")
                                .resizable()
                                .frame(width: 18, height: 18)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            heart[index].toggle()
                        }, label: {
                            Image(heart[index] ? "heart" : "heart_gray")
                        })
                        Spacer()
                        
                    }
                    Spacer()
                    
                    Text("\(index+1)/3")
                        .font(.medium12)
                        .foregroundStyle(Color.gray60)
                    
                    
                }
                .padding(.all,10)
            }
            
        }
        .background(Color.white)
        .cornerRadius(12)
        .frame(width: 200,height: 200)
        .shadow(color: Color.darkGreen.opacity(0.3), radius: 10, x: 0, y: 4)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}


//#Preview {
//    ResultView(result: YoutubeData(youtubeDataList: [Video(videoId: "12345", tumbnailUrl: "12345", title: "12345")]))
//}
