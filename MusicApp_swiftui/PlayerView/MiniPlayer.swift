//
//  MiniPlayer.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct Miniplayer: View {

  @Binding var isPlaying: Bool
  let playerControl: (PlayerControl) -> Void
  @EnvironmentObject var vm: PlayerViewModel

  var height = UIScreen.main.bounds.height / 3
  var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
  @State var offset : CGFloat = 0
  
  var body: some View {
    
    VStack {
      
      HStack(spacing: 15) {
        
        vm.album!.getImage
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 55, height: 55)
          .cornerRadius(15)

        VStack {
          Text(vm.album!.artist)
            .font(.title2)
          Text(vm.currentSong!.title)
            .font(.title2)
            .fontWeight(.bold)
        }
        // .matchedGeometryEffect(id: "Label", in: animation)
        
        Spacer(minLength: 0)
        
        Button(action: {
          self.playerControl(.playAndPause)
        }, label: {
          Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
            .font(.title2)
            .foregroundColor(.white)
        })
        
        Button(action: {
          self.playerControl(.next)
        }, label: {
          
          Image(systemName: "forward.fill")
            .font(.title2)
            .foregroundColor(.white)
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

struct Miniplayer_Previews: PreviewProvider {
  static var previews: some View {
    let vm = PlayerViewModel()
    vm.currentSong = Song.example
    vm.album = Album.example
    return Miniplayer(isPlaying: .constant(true)) { playerControl in
      print(playerControl)
    }
    .environmentObject(vm)
  }
}
