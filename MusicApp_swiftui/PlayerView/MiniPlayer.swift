//
//  MiniPlayer.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct Miniplayer: View {
//    var animation: Namespace.ID
    @Binding var expand : Bool
    
    var height = UIScreen.main.bounds.height / 3
    
    // safearea...
    
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    // gesture Offset...
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 15) {

              Image("image1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .cornerRadius(15)
              
              Text("Lady Gaga")
                .font(.title2)
                .fontWeight(.bold)
              // .matchedGeometryEffect(id: "Label", in: animation)
              
              Spacer(minLength: 0)
              
              Button(action: {}, label: {
                
                Image(systemName: "play.fill")
                  .font(.title2)
                  .foregroundColor(.primary)
              })
              
              Button(action: {}, label: {
                
                Image(systemName: "forward.fill")
                  .font(.title2)
                  .foregroundColor(.primary)
              })
            }
            .padding(.horizontal)
        }
        // expanding to full screen when clicked...
        .frame(maxHeight: 80)
        // moving the miniplayer above the tabbar...
        // approz tab bar height is 49
    }
}
