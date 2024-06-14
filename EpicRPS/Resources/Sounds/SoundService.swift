//
//  SoundPlayer.swift
//

import Foundation
import AVFoundation

class SoundService {
    
    static let player = SoundService()

    var avPlayer: AVAudioPlayer!
    var strokePlayer: AVAudioPlayer!
    
    private init() {}
    
    func play(key: Sounds, isHit: Bool = false) {
        let url = Bundle.main.url(forResource: key.rawValue, withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        do {
            if !isHit {
                avPlayer = try AVAudioPlayer(contentsOf: url!)
                avPlayer?.play()
            } else {
                strokePlayer = try AVAudioPlayer(contentsOf: url!)
                strokePlayer?.play()
            }
          
        } catch {
            print("\(error)")
        }
    }
}
