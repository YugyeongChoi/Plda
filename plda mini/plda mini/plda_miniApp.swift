//
//  plda_miniApp.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

@Observable
class Path {
    var stack : NavigationPath = NavigationPath()
}

@main
struct plda_miniApp: App {
    @State private var path = Path()
    @State private var diaryStore = DiaryStore()
    @State private var prefferdVideos = PrefferdVideoStore()
    @State private var profile = Profile.default
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(path)
                .environment(diaryStore)
                .environment(prefferdVideos)
                .environment(profile)
            
        }
    }
}
