//
//  LockScreenController.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/23.
//

import Foundation
import MediaPlayer

class LockScreenController {
  let player: AVPlayer
  
  init(player: AVPlayer) {
    self.player = player
  }
  
  func setupRemoteTransportControls( playControl: @escaping (PlayerControl) -> Void) {
    // Get the shared MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()
    
    // Add handler for Play Command
    commandCenter.playCommand.addTarget { [unowned self] event in
      if self.player.rate == 0.0 {
        playControl(.play)
        return .success
      }
      return .commandFailed
    }
    // Add handler for Pause Command
    commandCenter.pauseCommand.addTarget { [unowned self] event in
      if self.player.rate == 1.0 {
        playControl(.pause)
        return .success
      }
      return .commandFailed
    }

    commandCenter.nextTrackCommand.addTarget { _ in
      playControl(.next)
      return .success
    }

    commandCenter.previousTrackCommand.addTarget { _ in
      playControl(.previous)
      return .success
    }
  }
  
  func setupNowPlaying() {
    // Define Now Playing Info
    let metadata = self.player.currentItem!.asset.commonMetadata

    let artistItem = AVMetadataItem.metadataItems(
      from: metadata,
      filteredByIdentifier: .commonIdentifierArtist
    )
    let titleItem = AVMetadataItem.metadataItems(
      from: metadata,
      filteredByIdentifier: .commonIdentifierTitle
    )
    let imageItem = AVMetadataItem.metadataItems(
      from: metadata,
      filteredByIdentifier: .commonIdentifierArtwork
    )

    var nowPlayingInfo = [String : Any]()
    nowPlayingInfo[MPMediaItemPropertyArtist] = artistItem[0].value
    nowPlayingInfo[MPMediaItemPropertyTitle] = titleItem[0].value

    if let image = UIImage(data: imageItem[0].dataValue!) {
      nowPlayingInfo[MPMediaItemPropertyArtwork] =
        MPMediaItemArtwork(boundsSize: image.size) { size in
          return image
        }
    }
    
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentItem!.currentTime().seconds
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.currentItem!.asset.duration.seconds
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate

    // Set the metadata
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
}
