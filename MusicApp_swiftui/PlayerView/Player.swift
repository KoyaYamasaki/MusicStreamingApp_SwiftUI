//
//  Player.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI
import AVFoundation

enum PlayerControl {
  case start
  case playAndPause
  case next
  case previous
}

struct Player: View {
  @EnvironmentObject var vm: PlayerViewModel
  @Binding var expand: Bool

  @State private var isPlaying: Bool = true
  var height = UIScreen.main.bounds.height / 3
  @State var offset : CGFloat = 0
  
  var body: some View {
    if vm.album != nil && vm.currentSong != nil {
      Group {
        if expand {
          PlayerView(isPlaying: $isPlaying) { playerControl in
            print("playerControl")
            onReceivePlayerControl(playerControl)
          }
          .environmentObject(vm)
          .frame(maxHeight: .infinity)
        } else {
          Miniplayer(isPlaying: $isPlaying) { playerControl in
           print("playerControl")
           onReceivePlayerControl(playerControl)
         }
          .environmentObject(vm)
        }
      } //: Group
      .onAppear() {
        print("onAppear")
        // don't start if the player is in pause.
        if self.isPlaying {
          print("player is not in pause")
          self.start()
        }
      }
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

  func onReceivePlayerControl(_ playerControl: PlayerControl) {

    switch playerControl {
    case .start:
      start()
    case .playAndPause:
      playPause()
    case .next:
      next()
    case .previous:
      previous()
    }
  }

  func onchanged(value: DragGesture.Value) {
    
    // only allowing when its expanded...
    
    if value.translation.height > 0 && expand {
      
      offset = value.translation.height
    }
  }
  
  func onended(value: DragGesture.Value) {
    
    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
      
      // if value is > than height / 3 then closing view...
      
      if value.translation.height > height {
        
        expand = false
      }
      
      offset = 0
    }
  }

  func start() {
    print("start in")
    
    if self.vm.player.rate == 0 {
      do {
        try AVAudioSession.sharedInstance().setActive(true)
      } catch {
        print(error)
      }

      self.vm.setPlayerItem(song: self.vm.currentSong!)
      print(self.vm.player.currentItem?.asset.duration.seconds)
      self.vm.player.play()
    }
  }

  func playPause() {
    if !isPlaying {
      vm.player.play()
    } else {
      vm.player.pause()
    }
    self.isPlaying.toggle()
  }
  
  func next() {
    print("next in")
    if vm.currentSong!.track < vm.album!.songs.count {
      vm.player.pause()
      vm.currentSong = vm.album!.songs.first(where: {$0.track == (vm.currentSong!.track+1)})!
      self.vm.setPlayerItem(song: self.vm.currentSong!)
      // don't start if the player is in pause.
      if self.isPlaying {
        print("player is not in pause")
        self.vm.player.play()
      }
    }
  }
  
  func previous() {
    if vm.currentSong!.track > 1 {
      vm.player.pause()
      vm.currentSong = vm.album!.songs.first(where: {$0.track == (vm.currentSong!.track-1)})!
      self.vm.setPlayerItem(song: self.vm.currentSong!)
      // don't start if the player is in pause.
      if self.isPlaying {
        print("player is not in pause")
        self.vm.player.play()
      }
    }
  }
  
}

struct Player_Previews: PreviewProvider {
  static var previews: some View {
    Player(expand: .constant(false))
  }
}
