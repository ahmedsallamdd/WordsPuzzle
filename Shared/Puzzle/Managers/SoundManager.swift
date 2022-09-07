//
//  SoundEffectPlayer.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 22/08/2022.
//

import Foundation
import AVFAudio

class SoundManager {
    fileprivate var player: AVAudioPlayer?
    
    func playErrorSoundEffect() {
        self.playSoundEffect(filename: "wrongAnswer", fileType: "mp3")
    }
    
    func playCorrectAnswerSoundEffect() {
        self.playSoundEffect(filename: "correctAnswer", fileType: "mp3")
    }
    
    fileprivate func playSoundEffect(filename: String, fileType: String, rate: Float? = 1.0) {
        if let pathToSoundEffect = Bundle.main.path(forResource: filename, ofType: fileType) {
            let soundEffectURL = URL(fileURLWithPath: pathToSoundEffect)
            
            do {
                self.player = try AVAudioPlayer(contentsOf: soundEffectURL)
                self.player?.enableRate = true
                self.player?.rate = rate ?? 1.99
                self.player?.play()
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        } else {
            print("Couldn't find the sound effect!")
        }
    }
}
