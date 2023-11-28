//
//  RecommendSheetView.swift
//  Plda mini
//
//  Created by 최유경 on 11/28/23.
//

import Foundation
import SwiftUI

struct RecommendSheetView: View {
    @State var title: [String] = ["Ice Cream Cake", "손오공", "Drama"]
    @State var heart = [Bool] (repeating: false ,count :3)
    @State var isHeartTapped = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.darkGreen)
                .ignoresSafeArea()
                .offset(y:56)
            
            RoundedRectangle(cornerRadius: 40)
                .fill(.white)
                .ignoresSafeArea()
                .offset(y:110)
            
            VStack{
                TabView(){
                    ForEach(0..<title.count, id: \.self) { index in
                        VStack{
                            Spacer()
                            
                            Text(title[index])
                                .foregroundColor(.black)
                                .font(.bold16)
                                .padding(.bottom,18)
                            
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    //유튜브로 이동
                                }, label: {
                                    Image("play")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                })
                                
                                Spacer()
                            }
                            Spacer()
                            
                            Text("\(index+1)/3")
                                .font(.medium12)
                                .foregroundStyle(Color.gray60)
                            
                            
                        }
                        .padding(.all,10)
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .frame(width: 200,height: 200)
                .shadow(color: Color.darkGreen.opacity(0.3), radius: 10, x: 0, y: 4)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
            }
            .offset(y:-40)

        }
    }
}


