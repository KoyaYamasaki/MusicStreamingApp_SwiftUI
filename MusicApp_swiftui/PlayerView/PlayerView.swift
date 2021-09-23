//
//  PlayerView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
  @EnvironmentObject var vm: PlayerViewModel
  @Binding var playerExpand: Bool

  var height = UIScreen.main.bounds.height / 3
  @State var offset : CGFloat = 0
  
  var body: some View {
    if vm.album != nil && vm.currentSong != nil {
      Group {
        if playerExpand {
          FullPlayer()
          .environmentObject(vm)
          .frame(maxHeight: .infinity)
        } else {
          Miniplayer()
          .environmentObject(vm)
        }
      } //: Group
      .onAppear() {
        print("PlayerView onAppear")
      }
      .onReceive(vm.publisher) { item in
        print("PlayerView onReceive finishedObserver.publisher")
        self.vm.next()
      }
      .onDisappear() {
        print("PlayerView onDisappear")
      }
      .onTapGesture(perform: {
        withAnimation(.spring()) {
          playerExpand = true
        }
      })
      .cornerRadius(playerExpand ? 20 : 0)
      //      .offset(y: expand ? 0 : -48)
      .offset(y: offset)
      .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
      .ignoresSafeArea()
    }
  } //: body

  func onchanged(value: DragGesture.Value) {
    
    // only allowing when its expanded...
    
    if value.translation.height > 0 && playerExpand {
      
      offset = value.translation.height
    }
  }
  
  func onended(value: DragGesture.Value) {
    
    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
      
      // if value is > than height / 3 then closing view...
      
      if value.translation.height > height {
        
        playerExpand = false
      }
      
      offset = 0
    }
  }
  
}

struct Player_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(playerExpand: .constant(false))
  }
}
