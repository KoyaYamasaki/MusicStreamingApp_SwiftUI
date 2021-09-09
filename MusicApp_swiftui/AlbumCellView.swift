//
//  AlbumCellView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/03.
//

import SwiftUI

struct AlbumCellView: View {
  let album: Album
  
  var body: some View {
    HStack(spacing: 10) {
      album.getImage.resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 50, height: 70)
        .padding(.leading, 10)

      Spacer()
      VStack(alignment: .trailing, spacing: 5) {
        Text(album.title)
        Text("Tracks : \(album.tracks)")
      }
      .lineLimit(1)
      .minimumScaleFactor(0.5)
      .padding(.trailing, 10)
    }
  }
}

struct AlbumCellView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCellView(album: Album.example)
      .previewLayout(.fixed(width: 500, height: 70))
  }
}
