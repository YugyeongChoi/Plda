//
//  MainView.swift
//  plda mini
//
//  Created by chaebeen on 11/9/23.
//

import SwiftUI

struct MainView: View {
    @Environment(Path.self) var path
    @Environment(DiaryStore.self) var diaryStore
    
    var body: some View {
        @Bindable var path = path
        
        NavigationStack (path: $path.stack){
            
            VStack{
                ScrollView(.vertical, showsIndicators: true){
                    VStack{
                        ForEach(diaryStore.list, id: \.id) { diary in
                            HStack{
                                VStack{
                                    HStack{
                                        Text(diary.title)
                                            .font(.bold16)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    HStack{
                                        Spacer()
                                        Text("20230706")
                                            .font(.medium12)
                                            .foregroundColor(.gray80)
                                    }
                                }
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                
                            }
                            .background(.white)
                            .cornerRadius(6)
                            .shadow(color: Color.darkGreen.opacity(0.3), radius: 10, x: 0, y: 4)
                            .padding(EdgeInsets(top: 5, leading: 20, bottom:0, trailing: 20))
                        } //Foreach
                    } //VStack
                    .padding(.top,12)
                    .padding(.bottom,30)
                    .navigationBarTitle("")
                    .navigationBarItems(
                        leading:
                            Text("PLAY DIARY")
                            .font(.extraBold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.darkGreen),
                        trailing:
                            HStack {
                                Button(action: {}) {
                                    Image("heart")
                                        .frame(width: 20, height: 18)
                                }
                                
                                Button(action: {}) {
                                    Image("setting")
                                        .frame(width: 20, height: 16)
                                    
                                }
                            })
                    .navigationDestination(for: Int.self) { x in
                        EditView()
                    }
                    Spacer()
                } //ScrollView
                
                ZStack{
                    Button(action: {}) {
                        VStack{
                            NavigationLink(value: 1) {
                                Image("pencil")
                                    .frame(width: 42, height: 42)
                                    .padding(.bottom,30)
                                    .padding(.horizontal,40)
                            }
                        }
                    }
                }
                
            } //VStack
            .background(Image("background2"))
        } //NavigationStack
        
    }
}


//#Preview {
//    MainView()
//        .environment(Path())
//        .environment(DiaryStore())
//}

