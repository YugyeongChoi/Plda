//
//  EditsettingView.swift
//  Plda
//
//  Created by 최유경 on 2023/08/09.
//

import SwiftUI
import PhotosUI

struct EditsettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment (Profile.self) var profile
    
    @State var draftProfile: Profile = Profile.default
    @State private var userImageItem: PhotosPickerItem?
    
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                PhotosPicker(selection: $userImageItem,
                             matching: .images,
                             photoLibrary: .shared()) {
                    draftProfile.userProfileImage
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay{
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                        .padding(.horizontal,40)
                        .padding(.bottom,80)
                }
                
                
                TextField("닉네임", text: $draftProfile.username)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.horizontal,20)
                    .padding(.bottom,45)
                
                HStack{
                    Spacer()
                    Text("변경")
                        .font(.bold16)
                        .foregroundColor(.white)
                        .padding(.vertical,9)
                    Spacer()
                }
                .background(Color.darkGreen)
                .cornerRadius(12)
                .padding(.horizontal,20)
                
                Spacer()
                HStack{
                    Spacer()
                    Text("로그아웃")
                        .font(.bold16)
                        .foregroundColor(.gray60)
                }.padding(.trailing,25)
                    .padding(.bottom,30)
            }
            .background(Image("background2"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onChange(of: userImageItem) { _ in
            Task {
                if let data = try? await userImageItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        draftProfile.userProfileImage = Image(uiImage: uiImage)
                        return
                    }
                }
                print("Failed")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(){
                    Button(action: {
                        profile.set(username: draftProfile.username, userProfileImage: draftProfile.userProfileImage)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("left")
                    })
                    Spacer()
                }
            }
        }
    }
}
