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
    @State var title: [String] = ["Ice Cream Cake", "손오공", "Drama"]
    @State var heart = [Bool] (repeating: false ,count :3)
    @State var isHeartTapped = false
    

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
                        
            if let result = result {
                TabView(){
                    ForEach(0..<result.youtubeDataList.count, id: \.self) { index in
                        VStack{
                            Spacer()
                            
                            AsyncImage(url: URL(string: result.youtubeDataList[index].tumbnailUrl)) { image in
                                image.resizable()
                                } placeholder: {
                                    ProgressView()
                            }
                                                        
                            Text(result.youtubeDataList[index].title)
                                .foregroundColor(.black)
                                .font(.bold16)
                                .padding(.bottom,18)

                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    if let url = URL(string: "https://www.youtube.com/watch?v=" +  result.youtubeDataList[index].videoId) {
                                        UIApplication.shared.open(url, options: [:])}
                                    
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


