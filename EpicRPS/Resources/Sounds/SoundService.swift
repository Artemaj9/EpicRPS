//
//  SoundPlayer.swift
//

import AVFoundation
import Foundation

class SoundService {

    static let player = SoundService()

    var avPlayer: AVAudioPlayer!
    var strokePlayer: AVAudioPlayer!
    var hitPlayer: AVAudioPlayer!

    private init() {
        setupAudioSession()
    }

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
    }

    func preloadAudio(file: String, isStroke: Bool = true) {
        if let path = Bundle.main.path(forResource: file, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                if isStroke {
                    strokePlayer = try AVAudioPlayer(contentsOf: url)
                    strokePlayer?.prepareToPlay()
                } else {
                    hitPlayer = try AVAudioPlayer(contentsOf: url)
                    hitPlayer?.prepareToPlay()
                }
            } catch {
                print("Error loading audio file: \(error)")
            }
        }
    }

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
