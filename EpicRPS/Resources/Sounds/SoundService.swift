//
//  SoundService.swift

import Foundation
import AVFoundation

class SoundService {
    static let player = SoundService()
    var avPlayer: AVAudioPlayer!
    
    private init() {}
    
    func play(key: Sounds) {
        let url = Bundle.main.url(forResource: key.rawValue, withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url!)
            avPlayer?.play()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
