//
//  Player.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct Player: View {
  var album: Album = Album.example
  @Binding var expand: Bool
  var height = UIScreen.main.bounds.height / 3
  @State var offset : CGFloat = 0

  var body: some View {
    if album != nil {
      Group {
        if expand {
          PlayerView(vm: PlayerViewModel(currentSong: Song.example, album: Album.example))
            .frame(maxHeight: .infinity)
        } else {
          Miniplayer(expand: $expand)
        }
      } //: Group
      .onTapGesture(perform: {
        withAnimation(.spring()) {
          expand = true
        }
      })
      .cornerRadius(expand ? 20 : 0)
//      .offset(y: expand ? 0 : -48)
      .offset(y: offset)
      .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
      .ignoresSafeArea()
    }
  } //: body

  func onchanged(value: DragGesture.Value){
      
      // only allowing when its expanded...
      
      if value.translation.height > 0 && expand {
          
          offset = value.translation.height
      }
  }
  
  func onended(value: DragGesture.Value){
      
      withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
          
          // if value is > than height / 3 then closing view...
          
          if value.translation.height > height {
              
              expand = false
          }
          
          offset = 0
      }
  }

}

struct Player_Previews: PreviewProvider {
  static var previews: some View {
    Player(expand: .constant(false))
  }
}
