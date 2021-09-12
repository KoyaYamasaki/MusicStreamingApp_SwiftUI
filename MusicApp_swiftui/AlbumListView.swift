//
//  ArtistFeatureView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI

struct AlbumListView: View {
  let artist: Artist
  let albumsHandler: ([Album]) -> Void
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @StateObject private var lsAlbums = LSAlbums()
  @State private var selectedAlbum: Album?

  var body: some View {
    VStack {
      List {
        ForEach(getAlbums, id: \.self) { album in
          Button(action: {
            if selectedAlbum == nil {
              selectedAlbum = album
            } else {
              selectedAlbum = nil
            }
          }, label: {
            AlbumCellView(album: album)
          })
          
          if selectedAlbum != nil && selectedAlbum == album {
            ForEach(selectedAlbum!.songs, id: \.self) { song in
              NavigationLink(destination: PlayerView(album: selectedAlbum!, initialTrackNumber: song.track)) {
                Text(song.title)
                  .font(.subheadline)
                  .padding([.leading])
              }
            }
          }
        } //: ForEach
        .listRowBackground(
          Color.black
        )
      } //: List
      .edgesIgnoringSafeArea(.top)
      .navigationTitle(artist.name)
    } //: VStack
    .foregroundColor(.white)
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(
      leading:
        Button(action : {
          // TODO: Need more clean code.
          if artist.albums != nil {
            self.mode.wrappedValue.dismiss()
          } else {
            // Back to main view by implementing
            // Artist's albums.
            albumsHandler(lsAlbums.data)
          }
        }){
          HStack {
            Image(systemName: "arrow.left")
            Text("Artist List")
          }
        })
    .onAppear {
      UITableView.appearance().backgroundColor = UIColor.black
      if artist.albums == nil {
        lsAlbums.fetchData(for: artist)
      }
    }
  } //: body

  var getAlbums: [Album] {
    if let albums = artist.albums {
      return albums
    } else {
      return lsAlbums.data
    }
  }
}

struct ArtistFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumListView(artist: Artist.example) { artist in
      print(artist)
    }
  }
}