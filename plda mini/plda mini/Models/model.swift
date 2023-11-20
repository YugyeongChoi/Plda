//
//  model.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import Foundation

@Observable
class Diary : Identifiable {
    let id : UUID
    var title : String
    var content : String
    var youtubeData : YoutubeData?
    
    init(title : String, content : String) {
        id = UUID()
        self.title = title
        self.content = content
        self.youtubeData = nil
    }
    
    func youtubeDataListUpdate(list: YoutubeData) {
        self.youtubeData = list
    }
}

@Observable
class DiaryStore {
    var list: [Diary]
    
    init() {
        list = [
            Diary(title: "일기1", content: "어쩌고저쩌고"),
            Diary(title: "일기2", content: "어쩌고저쩌고"),
            Diary(title: "일기3", content: "어쩌고저쩌고"),
            Diary(title: "일기4", content: "어쩌고저쩌고"),
            Diary(title: "일기5", content: "어쩌고저쩌고"),
            Diary(title: "일기6", content: "어쩌고저쩌고"),
            Diary(title: "일기7", content: "어쩌고저쩌고"),
            Diary(title: "일기8", content: "어쩌고저쩌고"),
            Diary(title: "일기9", content: "어쩌고저쩌고")

        ]
    }
    
    func append(diary: Diary) {
        list.insert(diary, at: 0)
    }
}


struct Video: Codable {
    let videoId: String
    let tumbnailUrl: String
    let title: String
}

struct YoutubeData: Codable {
    let youtubeDataList: [Video]
}

let jsonData = """
{
    "youtubeDataList": [
        {
            "videoId": "kMRLzSQorK0",
            "tumbnailUrl": "https://i.ytimg.com/vi/kMRLzSQorK0/hqdefault.jpg",
            "title": "[MV] KIM DONG RYUL (김동률) _ Reply (답장)"
        },
        {
            "videoId": "zjVlcAI7b9E",
            "tumbnailUrl": "https://i.ytimg.com/vi/zjVlcAI7b9E/hqdefault.jpg",
            "title": "[보이는 멜로디] 엠씨더맥스 - 나를 보낸다 옥타브 체크"
        },
        {
            "videoId": "Qle5cfCcuEY",
            "tumbnailUrl": "https://i.ytimg.com/vi/Qle5cfCcuEY/hqdefault.jpg",
            "title": "[따라學IT] 10. NAT와 포트 포워딩 - 이론"
        }
    ]
}
"""


func requestPost(text: String) async throws -> YoutubeData? {
    let urlString = "http://61.254.228.107:1207/gpt/post"
    //let urlString = "https://7ad3379c-0fd7-4382-a079-b51b5090b05f.mock.pstmn.io/post"
    //let urlString = "http://61.254.228.107:1207/api/articles"

    guard let url = URL(string: urlString) else { throw PostErr.urlError }
        
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    //request.httpMethod = "GET"
    
    let textParameter = "text=\(text)"
    
    request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = textParameter.data(using: .utf8)

    let (data, _) = try await URLSession.shared.data(for: request)
    
    print(data)
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(YoutubeData.self, from: data)
    }
    catch {
        print("decode fail")
        throw PostErr.decodeError
    }
}

enum PostErr: Error {
    case urlError
    case decodeError
}

