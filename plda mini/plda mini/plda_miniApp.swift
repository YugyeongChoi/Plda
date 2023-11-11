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
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(path)
        }
    }
}
