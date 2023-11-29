//
//  PlaylistView.swift
//  Plda mini
//
//  Created by 최유경 on 11/20/23.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(Path.self) var path
    @Environment(PrefferdVideoStore.self) var prefferedVideos
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: true){
                if (prefferedVideos.list.isEmpty) {
                    VStack{
                        Spacer()
                        Text("추가한 노래가 없습니다.")
                    }
                }
                else {
                    playListView()
                }
            }
            .background(Image("background2"))
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    Text("PLAY LIST")
                    .font(.extraBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.darkGreen),
                trailing:
                    HStack {
                        Button(action: {
                            path.stack.removeLast()
                        }) {
                            Image("home")
                                .frame(width: 20, height: 18)
                        }
                    })
        
    }
}

private func playListView() -> some View {
    @State var title: [String] = ["제목1", "제목2", "제목3"]
    @Environment(PrefferdVideoStore.self) var prefferedVideos
    
    return VStack{
        ForEach(prefferedVideos.list, id:\.self) { video in
            HStack{
                VStack(spacing: 5){
                    HStack{
                        Text(video.title)
                            .font(.bold16)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.leading,10)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        Text("20230704")
                            .font(.medium12)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray80)
                            .padding(.trailing,5)
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 10))
            }
            .background(Color.gray10)
            .cornerRadius(12)
            .padding(EdgeInsets(top: 5, leading: 20, bottom:0, trailing: 20))
        }
    } //VStack
    .padding(.top,12)
    .padding(.bottom,30)
}
