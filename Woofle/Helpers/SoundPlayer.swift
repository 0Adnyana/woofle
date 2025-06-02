//
//  SoundPlayer.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 01/06/25.
//


import SwiftUI
import AVFoundation

class SoundPlayer {
    static let shared = SoundPlayer()
    
    var players: [AVAudioPlayer] = []
    
    func playSounds(soundNames: [String]) {
        players.removeAll() // Clear previous players if needed
        
        for soundName in soundNames {
            if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    player.play()
                    players.append(player)
                } catch {
                    print("Error playing sound \(soundName): \(error.localizedDescription)")
                }
            } else {
                print("Sound file \(soundName).mp3 not found.")
            }
        }
    }
}