//
//  ArtistCellView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI

struct ArtistListView: View {
  @ObservedObject var localServerData: LocalServerData
  var artist: Artist

  var body: some View {
    NavigationLink(destination: AlbumListView(artist: artist) { artist in
      print(artist)
    }) {
      HStack {
        ZStack {
          Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(.blue)
          Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
        }
        Text(artist.name).bold()
        Spacer()
      }.padding(20)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct ArtistListView_Previews: PreviewProvider {
    static var previews: some View {
      ArtistListView(localServerData: LocalServerData(), artist: Artist.example)
    }
}
