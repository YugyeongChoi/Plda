//
//  model.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import Foundation

var diaries : [Diary] = [
    Diary(id: 1000, title: "일기1", content: "어쩌고저쩌고"),
    Diary(id: 1001, title: "일기2", content: "어쩌고저쩌고"),
    Diary(id: 1002, title: "일기3", content: "어쩌고저쩌고")

]

struct Diary : Hashable, Codable, Identifiable {
    var id : Int
    var title : String
    var content : String
}
