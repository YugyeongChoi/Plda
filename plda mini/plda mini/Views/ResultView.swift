//
//  ResultView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct ResultView: View {
    @Environment(Path.self) var path
    var result: YoutubeData?

    var body: some View {
        if let result = result {
            VStack {
                Text(result.youtubeDataList[0].tumbnailUrl)
                Text(result.youtubeDataList[0].title)
                Text(result.youtubeDataList[0].videoId)
            }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        
                        Button {
                            path.stack.removeLast()

                        } label: {
                            
                            HStack {

                                Image(systemName: "chevron.backward")

                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    ResultView(result: YoutubeData(youtubeDataList: [Video(videoId: "12345", tumbnailUrl: "12345", title: "12345")]))
}
