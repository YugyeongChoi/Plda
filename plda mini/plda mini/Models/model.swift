//
//  model.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import Foundation

@Observable
class Diary : Identifiable, Hashable, Equatable{
    let id : UUID
    var title : String
    var content : String
    var editDate: Date
    var youtubeData : YoutubeData?
    
    init(title : String, content : String) {
        id = UUID()
        self.title = title
        self.content = content
        self.editDate = .now
        self.youtubeData = nil
    }
    
    func getEditDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self.editDate)
    }
    
    func youtubeDataListUpdate(list: YoutubeData) {
        self.youtubeData = list
    }
    
    static func == (lhs: Diary, rhs: Diary) -> Bool {
        return lhs.content == rhs.content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(content)
    }
}
@Observable
class DiaryStore {
    var list: [Diary]
    
    init() {
        list = [
            Diary(title: "일기1", content: "어쩌고저쩌고ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ"),
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

struct Feedback: Codable {
    var prompts_id: Int = 0
    var title: String = ""
    var feedback: Int = 0
    
    init(prompts_id: Int, title: String, feedback: Int) {
        self.prompts_id = prompts_id
        self.title = title
        self.feedback = feedback
    }
}

@Observable
class PrefferdVideoStore {
    var list: [Video] = []
    
    func append(video: Video) {
        list.append(video)
    }
}

class Video: Codable, Hashable {
    let videoId: String
    let tumbnailUrl: String
    let title: String

    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.videoId == rhs.videoId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(videoId)
        hasher.combine(tumbnailUrl)
        hasher.combine(title)
    }
}

//class TaggedVideo: Video {
//    var isPrefferd: Bool = false
//}

class YoutubeData: Codable {
    let youtubeDataList: [Video]
}

func requestPost(text: String, prompt: Int) async throws -> YoutubeData? {
    let urlString = "http://61.254.228.107:1207/gpt/post"

    guard let url = URL(string: urlString) else { throw PostErr.urlError }
        
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    
    request.setValue("\(prompt)", forHTTPHeaderField: "PROMPT")
    
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

func requestPost(feedbackData: [Feedback]) async throws {
    let urlString = "http://61.254.228.107:1207/feedbacks/post"

    guard let url = URL(string: urlString) else { throw PostErr.urlError }
        
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    
    let encoder = JSONEncoder()
    let encodeData = try encoder.encode(feedbackData)
    print(String(data: encodeData, encoding: .utf8)!)
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = encodeData
    
    let (_, _) = try await URLSession.shared.data(for: request)
}

enum PostErr: Error {
    case urlError
    case decodeError
}

