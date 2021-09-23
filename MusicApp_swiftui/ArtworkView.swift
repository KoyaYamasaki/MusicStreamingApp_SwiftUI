//
//  AlbumArtView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

struct ArtworkView: View {
  var artist: Artist?
  var album: Album?
  let isWithText: Bool

  var body: some View {
    ZStack(alignment: .bottom) {
      getImage.resizable().aspectRatio(contentMode: .fill)
        .frame(width: 200)

      if isWithText {
        ZStack {
          Blur(style: .dark )
          Text(getTitleText)
            .foregroundColor(.white)
            .font(.title)
        }
        .frame(height: 60, alignment: .center)
      }
    }
    .clipped().cornerRadius(20).shadow(radius: 10).padding(20)
  }

  var getImage: Image {
    if artist != nil && artist?.image != nil {
      return artist!.getImage
    } else if album != nil && album?.image != nil {
      return album!.getImage
    } else {
      return Image("image1")
    }
  }

  var getTitleText: String {
    if artist != nil {
      return artist!.name
    } else if album != nil {
      return album!.title
    } else {
      return "Unknown"
    }
  }
}

struct AlbumArtView_Previews: PreviewProvider {
    static var previews: some View {
      ArtworkView(artist: Artist.example, isWithText: true)
    }
}
