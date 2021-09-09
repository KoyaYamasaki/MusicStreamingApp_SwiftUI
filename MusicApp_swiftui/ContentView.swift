//
//  ContentView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var localServerData: LocalServerData
  @State private var currentArtist: Artist?
  
  @State private var currentSelection: Int = 0
  @State private var currentTranslation: CGFloat = 0

  @State private var previewCurrentPos: CGFloat = 1000
  @State private var previewNewPos: CGFloat = 1000
  var body: some View {
    NavigationView {
      ZStack {
        if !localServerData.artists.isEmpty {
          localServerData.artists[currentSelection].getImage.resizable().edgesIgnoringSafeArea(.all)
          Blur(style: .dark).edgesIgnoringSafeArea(.all)
        }
//        LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        GeometryReader { fullView in
          ArtistPagerView(
            pageCount: localServerData.artists.count,
            currentIndex: $currentSelection,
            translation: $currentTranslation, content: {
              ForEach(0..<self.localServerData.artists.count, id: \.self) { index in
                GeometryReader { geo in
                  VStack {
                    AlbumArtView(artist: self.localServerData.artists[index], isWithText: true)
                      .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                    NavigationLink(destination: AlbumListView(artist: self.localServerData.artists[index], localServerData: localServerData)) {
                      Text("Check All Albums")
                    }
                    .buttonStyle(SimpleButtonStyle(isDisabled: false))
                    .padding(.bottom, 20)
                  } //: VStack
                } //: GeometryReader
                .frame(width: 350)
              }
            })
            .padding(.horizontal, (fullView.size.width - 250) / 3)
        }
//          .frame(width: UIScreen.main.bounds.width)
      } //: ZStack
      .navigationTitle("Artists")
    } //: NavigationView
  } //: body

  init(localServerData: LocalServerData) {
    self.localServerData = localServerData
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
  }
}

struct SimpleButtonStyle: ButtonStyle {
    
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.body, design: .rounded))
            .foregroundColor(Color.white)
            .padding()
            .background(
              LinearGradient(
                gradient:
                  Gradient(colors: [Color("color1-dark"), Color("color1-light")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ).cornerRadius(10))
            .saturation(isDisabled ? 0 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let localServerMock = LocalServerData()
    localServerMock.artists = [Artist.example, Artist.example]

    return ContentView(localServerData: localServerMock)
      .previewDevice("iPhone 12")
  }
}
