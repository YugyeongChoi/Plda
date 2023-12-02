//
//  ProfileModel.swift
//  Plda mini
//
//  Created by chaebeen on 12/2/23.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class Profile {
    var username: String
    var userProfileImage: Image
    
    init(username: String, userProfileImage: Image) {
        self.username = username
        self.userProfileImage = userProfileImage
    }
    
    static var `default` = Profile(username: "닉네임", userProfileImage: Image(systemName: "person.fill"))
    
    func set(username: String, userProfileImage: Image) {
        self.username = username
        self.userProfileImage = userProfileImage
    }
}
