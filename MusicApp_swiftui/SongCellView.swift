//
//  SongCellView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

struct SongCellView: View {
  var album: Album
  var trackNumber: Int
  var body: some View {
    NavigationLink(destination: PlayerView(album: album, initialTrackNumber: trackNumber)) {
      HStack {
        ZStack {
          Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(.blue)
          Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
        }
        Text(album[trackNumber].name).bold()
        Spacer()
        Text(album[trackNumber].time)
      }.padding(20)
    }.buttonStyle(PlainButtonStyle())
  }
}

struct SongCellView_Previews: PreviewProvider {
    static var previews: some View {
      SongCellView(album: Album.example, trackNumber: Song.example.trackNumber)
    }
}
