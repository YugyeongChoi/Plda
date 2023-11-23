//
//  BottomsheetView.swift
//  Plda mini
//
//  Created by 최유경 on 11/23/23.
//

import SwiftUI

struct BottomsheetView: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 390, height: 572)
              .background(Color(red: 0.26, green: 0.48, blue: 0.36))
              .cornerRadius(40)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 390, height: 518)
              .background(Color(red: 0.95, green: 0.95, blue: 0.95))
              .cornerRadius(35)
        }
    }
}

#Preview {
    BottomsheetView()
}
