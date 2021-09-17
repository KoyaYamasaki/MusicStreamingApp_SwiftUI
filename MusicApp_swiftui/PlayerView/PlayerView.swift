//
//  PlayerView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {

  @ObservedObject var vm: PlayerViewModel

  @State private var isPlaying: Bool = true
//  let player = CustomPlayer()
  var safeArea = UIApplication.shared.windows.first?.safeAreaInsets

  var body: some View {
    ZStack {
      // TODO: Refactor to display actual album image
      vm.album.getImage.resizable().edgesIgnoringSafeArea(.all)
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
        AlbumArtView(album: vm.album, isWithText: false)
        Text(vm.album.title).font(.title).fontWeight(.light).foregroundColor(.white)
        Text(vm.currentSong.title).font(.title).fontWeight(.regular).foregroundColor(.white)
//          ProgressView(value: duration, total: 100)
        SeekBar(player: vm.player)
        .foregroundColor(.white)
        ZStack {
          HStack {
            Button { self.previous() } label: {
              Image(systemName: "arrow.left.to.line").resizable()
            }
            .disabled(vm.album.songs.first!.track == vm.currentSong.track)
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(vm.album.songs.first!.track != vm.currentSong.track ? .white : .gray)
            
            Button { self.playPause() } label: {
              Image(systemName: self.isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
            }.frame(width: 70, height: 70, alignment: .center).foregroundColor(.white).padding()
            
            Button { self.next() } label: {
              Image(systemName: "arrow.right.to.line").resizable()
            }
            .disabled(vm.album.songs.last!.track == vm.currentSong.track)
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(vm.album.songs.last!.track != vm.currentSong.track ? .white : .gray)
          } //: HStack
        } //: ZStack
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 200, alignment: .center)
      } //: VStack
      .padding(.bottom,80)
      .onAppear() {
        print("onAppear")
        self.start()
      }
      .onDisappear() {
        print("onDisappear")
      }
      .onReceive(vm.publisher) { item in
        print("onReceive finishedObserver.publisher")
        self.next()
      }
    }
  }

  var currentPlayerItem: AVPlayerItem {
    let songUrl = vm.currentSong.uri.replacingOccurrences(of: " ", with: "%20")
    let url = URL(string: localServerURL + songUrl)
    return AVPlayerItem(url: url!)
  }

  func start() {
    print("start in")
    if self.vm.player.rate == 0 {
      do {
        try AVAudioSession.sharedInstance().setActive(true)
      } catch {
        print(error)
      }

      self.vm.setPlayerItem(song: self.vm.currentSong)
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
    if vm.currentSong.track < vm.album.songs.count {
      vm.player.pause()
      vm.currentSong = vm.album.songs.first(where: {$0.track == (vm.currentSong.track+1)})!
      self.start()
    }
  }
  
  func previous() {
    if vm.currentSong.track > 1 {
      vm.player.pause()
      vm.currentSong = vm.album.songs.first(where: {$0.track == (vm.currentSong.track-1)})!
      self.start()
    }
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(vm: PlayerViewModel(currentSong: Song.example, album: Album.example))
  }
}
