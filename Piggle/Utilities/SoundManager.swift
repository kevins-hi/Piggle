//
//  SoundManager.swift
//  Piggle
//
//  Created by Kevin Shi on 7/22/21.
//

import AVKit
import Foundation

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    // Source: https://stackoverflow.com/questions/10322040/how-to-play-a-sound-using-avaudioplayer-when-in-silent-mode-in-iphone
    func ignoreSilentMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            //print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                //print("AVAudioSession is Active")
            } catch _ as NSError {
                //print(error.localizedDescription)
            }
        } catch _ as NSError {
            //print(error.localizedDescription)
        }
    }
    
    // Source: https://www.youtube.com/watch?v=iBLZ1C4L5Mw&ab_channel=SwiftfulThinking
    func playSound(_ soundName: String) {
        ignoreSilentMode()
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    func playRandOink() {
        let rand = Int.random(in: 1...4)
        let oinkNumber: Int
        if rand > 1 {
            oinkNumber = 1
        } else {
            oinkNumber = 2
        }
        
        let soundName = "oink" + String(oinkNumber)
        SoundManager.instance.playSound(soundName)
    }
    
    func playRandWewewe() {
        let rand = Int.random(in: 1...4)
        SoundManager.instance.playSound("wewewe" + String(rand))
    }
    
    // Source: https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
    func startBackgroundMusic(_ songName: String) {
        ignoreSilentMode()
        
        if let bundle = Bundle.main.path(forResource: songName, ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                player = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = player else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = player else { return }
        audioPlayer.stop()
    }
}
