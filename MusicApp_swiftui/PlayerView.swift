//
//  PlayerView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
  let album: Album
  let initialTrackNumber: Int
  @State private var currentTrackNumber = 0
  @State private var player = AVPlayer()
  @State private var isPlaying: Bool = false
  
  var body: some View {
    ZStack {
      // TODO: Refactor to display actual album image
      album.getImage.resizable().edgesIgnoringSafeArea(.all)
      Blur(style: .dark).edgesIgnoringSafeArea(.all)
      LinearGradient(
        gradient: Gradient(colors:[Color.black.opacity(0.0), Color.black.opacity(0.95)]),
        startPoint: .top,
        endPoint: .bottom
      )
      
      VStack {
        Spacer()
        AlbumArtView(album: album, isWithText: false)
        Text(album.title).font(.title).fontWeight(.light).foregroundColor(.white)
        Spacer()
        ZStack {
          HStack {
            Button { self.previous() } label: {
              Image(systemName: "arrow.left.circle").resizable()
            }.frame(width: 50, height: 50, alignment: .center).foregroundColor(.white)
            
            Button { self.playPause() } label: {
              Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
            }.frame(width: 70, height: 70, alignment: .center).foregroundColor(.white).padding()
            
            Button { self.next() } label: {
              Image(systemName: "arrow.right.circle").resizable()
            }.frame(width: 50, height: 50, alignment: .center).foregroundColor(.white)
          } //: HStack
        } //: ZStack
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 200, alignment: .center)
      } //: VStack
      .onAppear() {
        currentTrackNumber = initialTrackNumber
        start()
      }
    }
  }

  func start() {
    var url: URL?
    
    let urlAppendix = self.album[currentTrackNumber].uri.replacingOccurrences(of: " ", with: "%20")
    url = URL(string: localServerURL + urlAppendix)
    
    print(url)
    if let url = url {
      do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
      } catch {
        print(error.localizedDescription)
      }
      self.player = AVPlayer(playerItem: AVPlayerItem(url: url))
      self.player.play()
    }
  }

  func playPause() {
    if !isPlaying {
      player.play()
    } else {
      player.pause()
    }
    self.isPlaying.toggle()
  }
  
  func next() {
    if currentTrackNumber < album.songs.count {
      player.pause()
      currentTrackNumber += 1
      self.start()
    }
  }
  
  func previous() {
    if currentTrackNumber > 1 {
      player.pause()
      currentTrackNumber -= 1
      self.start()
    }
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(album: Album.example, initialTrackNumber: Song.example.track)
  }
}
