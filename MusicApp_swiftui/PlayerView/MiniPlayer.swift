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
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top,expand ? safeArea?.top : 0)
                .padding(.vertical,expand ? 30 : 0)
            
            HStack(spacing: 15) {
                
                // centering IMage...
                
                if expand {
                  Spacer(minLength: 0)
                }
                
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height : 55, height: expand ? height : 55)
                    .cornerRadius(15)
                
                if !expand {
                    
                    Text("Lady Gaga")
                        .font(.title2)
                        .fontWeight(.bold)
//                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: 0)
                
                if !expand {
                    
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
            }
            .padding(.horizontal)
            
            VStack(spacing: 15) {

                Spacer(minLength: 0)
                
                HStack{
                    
                    if expand{
                        
                        Text("Lady Gaga")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
//                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .padding(.top,20)

                // Controller Stack
                Button(action: {}) {
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                .padding()

              // Controller Stack
              Spacer(minLength: safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
//                .padding()
            }
            // this will give strech effect...
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        // expanding to full screen when clicked...
        .frame(maxHeight: expand ? .infinity : 80)
        // moving the miniplayer above the tabbar...
        // approz tab bar height is 49
        
        // Divider Line For Separting Miniplayer And Tab Bar....
        .background(
        
            VStack(spacing: 0){
                
                Blur()
                
                Divider()
            }
            .onTapGesture(perform: {
                
                withAnimation(.spring()){expand = true}
            })
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
    }
    
    func onchanged(value: DragGesture.Value){
        
        // only allowing when its expanded...
        
        if value.translation.height > 0 && expand {
            
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            
            // if value is > than height / 3 then closing view...
            
            if value.translation.height > height{
                
                expand = false
            }
            
            offset = 0
        }
    }
}
