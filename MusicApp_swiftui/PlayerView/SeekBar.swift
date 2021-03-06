//
//  SeekBar.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/16.
//

import SwiftUI
import AVFoundation

struct SeekBar: View {
  let player: AVPlayer
  @State var time: TimeInterval = 0.0

  init(player: AVPlayer) {
    self.player = player
  }

  var body: some View {
    let playbackDuration = self.player.currentItem?.asset.duration.seconds ?? 0
    let remainingTime = playbackDuration - time
    print("remainingTime: ", remainingTime)
    return HStack {
      Text(Self.timeToString(time: time))
      Slider(
        value: self.$time,
        in: 0...playbackDuration,
        onEditingChanged: { _ in
          self.player.seek(to: CMTime(seconds: self.time, preferredTimescale: 1000000))
      })
      Text(Self.timeToString(time: playbackDuration))
    }
    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
      self.time = self.player.currentItem?.currentTime().seconds ?? 0
    }
  }

  static func timeToString(time: TimeInterval) -> String {
    let second: Int
    let minute: Int
    second = Int(time) % 60
    minute = Int(time) / 60
    return "\(minute):\(NSString(format: "%02d", second))"
  }
}

struct SeekBar_Previews: PreviewProvider {
    static var previews: some View {
      SeekBar(player: AVPlayer())
    }
}
