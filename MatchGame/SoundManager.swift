//
//  SoundManager.swift
//  MatchGame
//
//  Created by walid wahba on 23.11.2023.
//

import Foundation
import AVFoundation


class SoundManager{
    
    var audioPlayer : AVAudioPlayer?
    
    //creat an enum
    enum SoundEffect {
        case flip
        case match
        case noMatch
        case shuffle
        
    }
    func playSound (effect:SoundEffect){
        
        var soundFileName = ""
        
        switch effect {
            
        case .flip:
            soundFileName = "cardflip"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .noMatch:
            soundFileName = "dingwrong"
            
        case .shuffle:
            soundFileName = "shuffle"
        }
        //Get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        //check if it's not nil make sure tha  bundle path not equal to nil otherwise do that
        guard bundlePath != nil else {
            
            return
        }
        
        //        if  bundlePath == nil {
        //            return
        //        }
        
        //create the url
        let url = URL(fileURLWithPath: bundlePath!)
        
        
        // the do catch is saying that tring this code maybe throws an error and we are trying to catch that error if it happens using try doing this code
        do {
            
            //Create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            //Play the sound effect
            audioPlayer?.play()
            
        }
        catch {
            print("Could't create an audio player ")
            return
        }
        
       
        
    }
}
