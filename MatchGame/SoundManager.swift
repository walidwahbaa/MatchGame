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
        
        
    }
}
