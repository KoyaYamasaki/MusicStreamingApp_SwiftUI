//
//  ArtistListView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

struct ArtistListView: View {
  @ObservedObject var lsArtists: LSArtists
  @Binding var playerExpand: Bool
  @EnvironmentObject var vm: PlayerViewModel

  @State private var currentSelection: Int = 0
  @State private var currentTranslation: CGFloat = 0

  var body: some View {
    NavigationView {
      ZStack {
        if !lsArtists.data.isEmpty {
          lsArtists.data[currentSelection].getImage.resizable().edgesIgnoringSafeArea(.all)
          Blur(style: .dark).edgesIgnoringSafeArea(.all)
          Rectangle()
            .foregroundColor(.clear)
            .background(LinearGradient(gradient: Gradient(colors: [Color("color\(currentSelection)-dark"), Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .opacity(0.5)
        }
        VStack {
          GeometryReader { fullView in
            ArtistPagerView(
              pageCount: lsArtists.data.count,
              currentIndex: $currentSelection,
              translation: $currentTranslation, content: {
                ForEach(0..<self.lsArtists.data.count, id: \.self) { index in
                  GeometryReader { geo in
                    VStack {
                      ArtworkView(artist: self.lsArtists.data[index], isWithText: true)
                        .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                      NavigationLink(destination: AlbumListView(artist: self.lsArtists.data[index], playerExpand: $playerExpand) { albums in
                        self.lsArtists.data[index].albums = []
                        self.lsArtists.data[index].albums?.append(contentsOf: albums)
                      })
                      {
                        Text("Check All Albums")
                      }
                      .buttonStyle(SimpleButtonStyle(currentIndex: currentSelection, isDisabled: false))
                      .padding(.bottom, 20)
                    } //: VStack
                  } //: GeometryReader
                  .frame(width: 350)
                }
              })
              .padding(.horizontal, (fullView.size.width - 250) / 3)
          } //: GeometryReader
        } //: VStack
        .offset(y: playerExpand ? 0 : -80)
      } //: ZStack
      .navigationTitle("Artists")
    } //: NavigationView
  } //: body
}

struct SimpleButtonStyle: ButtonStyle {
  let currentIndex: Int
  let isDisabled: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(.body, design: .rounded))
      .foregroundColor(Color.white)
      .padding()
      .background(
        LinearGradient(
          gradient:
            Gradient(colors: [Color("color\(currentIndex)-dark"), Color("color\(currentIndex)-light")]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        ).cornerRadius(10))
      .saturation(isDisabled ? 0 : 1)
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let lsArtistsMock = LSArtists()
    lsArtistsMock.data = [Artist.example, Artist.example]

    return ArtistListView(lsArtists: lsArtistsMock, playerExpand: .constant(false))
//      .environmentObject(localServerMock)
      .previewDevice("iPhone 12")
  }
}
