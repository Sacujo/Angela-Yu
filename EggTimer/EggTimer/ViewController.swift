//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 5,
        "Medium": 420,
        "Hard": 720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timeLeftLabel.isHidden = false
        timerLabel.isHidden = false
        
        
        progressBar.progress = 0.0
        secondsPassed = 0
        topLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        
        
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if player != nil  {
            player.stop()
        }
        timer.invalidate()
    }
    
    
    @objc func updateProgressView() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let remainingSeconds = totalTime - secondsPassed
            let minutes = Int(remainingSeconds) / 60 % 60
            let seconds = Int(remainingSeconds) % 60
            timerLabel.text = String(format:"%02i:%02i", minutes, seconds)
            let prosentageProgress = Float(secondsPassed) / Float(totalTime)

            progressBar.progress = prosentageProgress
        } else {
            topLabel.text = "Done!"
            playSound("alarm_sound")
            timer.invalidate()
            
            
        }
        
    }
    func playSound(_ name: String) {
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    

    
    
}



    
