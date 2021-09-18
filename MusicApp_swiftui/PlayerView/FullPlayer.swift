//
//  FullPlayer.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import AVFoundation

struct FullPlayer: View {

  @Binding var isPlaying: Bool
  let playerControl: (PlayerControl) -> Void
  @EnvironmentObject var vm: PlayerViewModel

  var safeArea = UIApplication.shared.windows.first?.safeAreaInsets

  var body: some View {
    ZStack {
      // TODO: Refactor to display actual album image
      vm.album!.getImage.resizable().edgesIgnoringSafeArea(.all)
      Blur(style: .dark).edgesIgnoringSafeArea(.all)
      LinearGradient(
        gradient: Gradient(colors:[Color.black.opacity(0.0), Color.black.opacity(0.95)]),
        startPoint: .top,
        endPoint: .bottom
      )
      
      VStack {
        Capsule()
          .fill(Color.gray)
          .frame(width: 60, height: 4)
          .opacity(1)
          .padding(.top, safeArea?.top ?? 0)
          .padding(.vertical, 30)
        Spacer()
        ArtworkView(album: vm.album, isWithText: false)
        Text(vm.album!.title).font(.title).fontWeight(.light).foregroundColor(.white)
        Text(vm.currentSong!.title).font(.title).fontWeight(.regular).foregroundColor(.white)
//          ProgressView(value: duration, total: 100)
        SeekBar(player: vm.player)
        .foregroundColor(.white)
        ZStack {
          HStack {
            Button { self.playerControl(.previous) } label: {
              Image(systemName: "arrow.left.to.line").resizable()
            }
            .disabled(vm.album!.songs.first!.track == vm.currentSong!.track)
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(vm.album!.songs.first!.track != vm.currentSong!.track ? .white : .gray)
            
            Button { self.playerControl(.playAndPause) } label: {
              Image(systemName: self.isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
            }.frame(width: 70, height: 70, alignment: .center).foregroundColor(.white).padding()
            
            Button { self.playerControl(.next) } label: {
              Image(systemName: "arrow.right.to.line").resizable()
            }
            .disabled(vm.album!.songs.last!.track == vm.currentSong!.track)
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(vm.album!.songs.last!.track != vm.currentSong!.track ? .white : .gray)
          } //: HStack
        } //: ZStack
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 200, alignment: .center)
      } //: VStack
      .padding(.bottom,80)
      .onDisappear() {
        print("onDisappear")
      }
      .onReceive(vm.publisher) { item in
        print("onReceive finishedObserver.publisher")
        self.playerControl(.next)
      }
    }
  }

  var currentPlayerItem: AVPlayerItem {
    let songUrl = vm.currentSong!.uri.replacingOccurrences(of: " ", with: "%20")
    let url = URL(string: localServerURL + songUrl)
    return AVPlayerItem(url: url!)
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    let vm = PlayerViewModel()
    vm.currentSong = Song.example
    vm.album = Album.example
    return FullPlayer(isPlaying: .constant(true)) { playerControl in
      print(playerControl)
    }
    .environmentObject(vm)
  }
}
