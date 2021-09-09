//
//  ArtistPagerView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/03.
//

import SwiftUI

struct ArtistPagerView<T: View>: View {
  let pageCount: Int
  @Binding var currentIndex: Int
  @Binding var translation: CGFloat
  let content: T

  init(
    pageCount: Int,
    currentIndex: Binding<Int>,
    translation: Binding<CGFloat>,
    @ViewBuilder content: () -> T
  ) {
    self.pageCount = pageCount
    self._currentIndex = currentIndex
    self._translation = translation
    self.content = content()
  }

  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 0) {
        self.content.frame(width: geometry.size.width)
      }
      .frame(width: geometry.size.width, alignment: .leading)
      .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
      .offset(x: self.translation)
      .animation(.interactiveSpring())
      .gesture(
        DragGesture(minimumDistance: 20)
          .onChanged({ value in
            translation = value.translation.width
          })
          .onEnded({ value in
            let offset = value.translation.width / geometry.size.width
            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
            currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
            translation = 0
          })
      )
    }
  }
}

struct ArtistPagerView_Previews: PreviewProvider {
  @State private var currentIndex: Int = 0
  @State private var translation: CGFloat = .zero

  static var previews: some View {
    PagerDummy()
  }
}

struct PagerDummy: View {
  @State private var currentIndex: Int = 0
  @State private var translation: CGFloat = .zero

  var body: some View {
    ArtistPagerView(pageCount: 3, currentIndex: $currentIndex, translation: $translation) {
      Color.red
      Color.blue
      Color.black
    }
  }
}
