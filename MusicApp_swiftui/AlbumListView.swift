//
//  ArtistFeatureView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI

struct AlbumListView: View {
  let artist: Artist
  @ObservedObject var localServerData: LocalServerData
  @State private var selectedAlbum: Album?
  
  var body: some View {
    VStack {
//      ZStack {
//        artist.getImage.resizable().aspectRatio(contentMode: .fit)
//          .frame(width: 270, height: 200, alignment: .center)
//        //      Blur(style: .regular).edgesIgnoringSafeArea(.all)
//        LinearGradient(
//          gradient: Gradient(colors:[Color.black.opacity(0.5), Color.black.opacity(1)]),
//          startPoint: .top,
//          endPoint: .bottom
//        )
//        .edgesIgnoringSafeArea(.all)
//
//      }
//      .frame(height: 250, alignment: .center)
//      .edgesIgnoringSafeArea(.bottom)
//      .background(Color.black)
      List {
          if artist.albums != nil {
            ForEach(artist.albums!, id: \.self) { album in
              Button(action: {
                if selectedAlbum == nil {
                  selectedAlbum = album
                } else {
                  selectedAlbum = nil
                }
              }, label: {
                AlbumCellView(album: album)
                  .frame(width: .infinity, height: 70)
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
//              ZStack {
//                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
//                Blur(style: .dark).edgesIgnoringSafeArea(.all)
//              }
              Color.black
            )
          }
      } //: List
      .edgesIgnoringSafeArea(.top)
      .navigationTitle(artist.name)
      .foregroundColor(.white)
    } //: VStack
    .foregroundColor(.white)
    .onAppear {
      UITableView.appearance().backgroundColor = UIColor.black
      localServerData.fetchData(for: artist)
    }
  }
}

struct ArtistFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumListView(artist: Artist.example, localServerData: LocalServerData())
  }
}
