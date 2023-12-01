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
    
    @State private var isPlayListPresented = false
    
    var body: some View {
        @Bindable var path = path
        
        NavigationStack (path: $path.stack){
            
            VStack{
                ScrollView(.vertical, showsIndicators: true){
                    VStack{
                        if(diaryStore.list.isEmpty){
                            VStack{
                                Spacer()
                                
                                Text("아직 아무것도 작성하지 않았어요!")
                                    .font(.bold16)
                                    .padding(.bottom,4)
                                
                                Text("하단의 아이콘을 눌러 일기를 작성해 볼까요?")
                                    .font(.bold16)
                            }
                            .padding(.top,300)
                        }
                        
                        ForEach(diaryStore.list, id: \.id) { diary in
                            NavigationLink(value: diary, label: {
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
                                            Text(diary.getEditDateString())
                                                .font(.medium12)
                                                .foregroundColor(.gray80)
                                        }
                                        
                                    }
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    
                                }
                                .background(.white)
                                .cornerRadius(12)
                                .shadow(color: Color.darkGreen.opacity(0.3), radius: 10, x: 0, y: 4)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom:0, trailing: 20))
                            })
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
                                NavigationLink(value : 2) {
                                    Image("playlist")
                                        .frame(width: 20, height: 18)
                                }
                                
                                NavigationLink(value : 3) {
                                    Image("setting")
                                        .frame(width: 20, height: 16)
                                }
                            })
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
            .navigationDestination(for: Diary.self) { diary in
                DetailView(diary: diary)
            }
            .navigationDestination(for: Int.self) { value in
                switch value {
                case 1 : EditView()
                case 2 : PlaylistView()
                case 3 : SettingView()
                default: Text("")
                }
            }
        } //NavigationStack
    }
}


//#Preview {
//    MainView()
//        .environment(Path())
//        .environment(DiaryStore())
//}
