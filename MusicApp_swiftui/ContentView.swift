//
//  ContentView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import Firebase

struct ContentView: View {
  @ObservedObject var firebaseData: FirebaseData
  @ObservedObject var localServerData: LocalServerData
  @State private var currentAlbum: Album?

  var body: some View {
    NavigationView {
      ScrollView {
//        ScrollView(.horizontal, showsIndicators: false) {
//          LazyHStack {
//            ForEach(self.firebaseData.albums, id: \.self) { album in
//              AlbumArtView(album: album, isWithText: true).onTapGesture {
//                self.currentAlbum = album
//              }
//            }
//          }
//        } //: ScrollView
        LazyVStack {
          if self.currentAlbum?.songs != nil {
            ForEach(self.currentAlbum!.songs, id: \.trackNumber) { song in
//              SongCellView(album: self.currentAlbum!, trackNumber: song.trackNumber)
              ArtistCellView(artist: Artist.example)
            }
          }
        }
      } //: ScrollView
      .navigationTitle("My Band Name")
    } //: NavigationView
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView(firebaseData: FirebaseData(), localServerData: LocalServerData())
  }
}
