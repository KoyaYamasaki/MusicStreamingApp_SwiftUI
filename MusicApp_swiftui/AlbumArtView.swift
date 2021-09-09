//
//  AlbumArtView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

struct AlbumArtView: View {
  var album: Album
  var isWithText: Bool
  var body: some View {
    ZStack(alignment: .bottom) {
      Image(album.image).resizable().aspectRatio(contentMode: .fill)

      if isWithText {
        ZStack {
          Blur(style: .dark )
          Text(album.name).foregroundColor(.white)
        }.frame(height: 60, alignment: .center)
      }
    }.frame(width: 170, height: 200, alignment: .center)
    .clipped().cornerRadius(20).shadow(radius: 10).padding(20)
  }
}

struct AlbumArtView_Previews: PreviewProvider {
    static var previews: some View {
      AlbumArtView(album: Album.example, isWithText: true)
    }
}
