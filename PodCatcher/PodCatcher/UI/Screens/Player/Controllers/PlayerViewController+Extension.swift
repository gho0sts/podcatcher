//
//  PlayerViewController+Extension.swift
//  PodCatcher
//
//  Created by Christopher Webb-Orenstein on 6/7/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreMedia

// MARK: - PlayerViewDelegate

extension PlayerViewController: PlayerViewDelegate {
    
    func updateTimeValue(time: Double) {
        if let user = user {
            user.totalTimeListening += time
        }
        let timeTrans = CMTime(value: CMTimeValue(time * 100), timescale: 1)
        player.player.seek(to: timeTrans)
        DispatchQueue.main.async {
            self.playerView.updateProgressBar(value: time / 100)
        }
    }
    
    func backButtonTapped() {
        index -= 1
    }
    
    func skipButtonTapped() {
        index += 1
    }
    
    func pauseButtonTapped() {
        player.player.pause()
    }
    
    func playButtonTapped() {
        player.play(player: player.player)
        player.observePlayTime()
    }
}

extension PlayerViewController: AudioFilePlayerDelegate {
    
    func trackFinishedPlaying() {
        print("Finished")
    }
    
    func trackDurationCalculated(stringTime: String, timeValue: Float64) {
        DispatchQueue.main.async {
            self.playerViewModel.totalTimeString = stringTime
            self.playerViewModel.playTimeIncrement = self.playerViewModel.playTimeIncrement / Float(timeValue)
            self.setModel(model: self.playerViewModel)
        }
    }
    
    func updateProgress(progress: Double) {
        print(progress)
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.playerView.updateProgressBar(value: progress)
        }
    }
}
