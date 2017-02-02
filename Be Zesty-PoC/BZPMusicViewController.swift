//
//  BZPMusicViewController.swift
//  Be Zesty-PoC
//
//  Created by Aditya Vikram Godawat on 01/02/17.
//  Copyright © 2017 Wow Labz. All rights reserved.
//

import UIKit
import AVFoundation


class BZPMusicViewController: UIViewController {

    // MARK: - Variables
    
    let filePrefix = ((_LANG_CODE == "es") ? "Spanish" : "English" )
    let fileNames = ["_BeachGI", "_ForestGI", "_DeepBreathing"]
    let choiceNames = ["Ocean Meditation", "Forest Meditation", "Deep Breathing"]
    let type = "mp3"
    var choice = 0
    
    
    // MARK: - Outlets
    
    var player = AVAudioPlayer()
    var scrubSlider = UISlider()
    var playButton = UIButton()
    let timerLabel = UILabel()
    let buttonChoice1 = UIButton()
    let buttonChoice2 = UIButton()
    var timer = Timer()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = choiceNames[0]

        setupView()
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    // MARK: - User Actions
    
    func setupView() {
        
        // Variables
        let aPadding = CGFloat(30)
        let aMaxWidth = self.view.frame.width
        let aMaxHeight = self.view.frame.height
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: filePrefix+fileNames[0], ofType: type)!))
            
        }catch {
            print("Error!")
        }
        
        playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        playButton.layer.cornerRadius = 150/2
        playButton.backgroundColor = .blue
        playButton.setTitle("Play", for: .normal)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        playButton.center = view.center
        view.addSubview(playButton)
        
        scrubSlider = UISlider(frame: CGRect(x: 2*aPadding, y: playButton.frame.maxY+aPadding, width: aMaxWidth-4*aPadding, height: 45))
        scrubSlider.maximumValue = Float(player.duration)
        scrubSlider.addTarget(self, action: #selector(scrub), for: .valueChanged)
        view.addSubview(scrubSlider)

        timerLabel.frame = CGRect(x: scrubSlider.frame.minX, y: scrubSlider.frame.maxY+aPadding/3, width: 150, height: 30)
        timerLabel.text = "00:00:00/\(stringFromTimeInterval(interval: player.duration))"
        timerLabel.font = UIFont.systemFont(ofSize: 9)
        view.addSubview(timerLabel)
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding+2, height: 45))
        aView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        aView.layer.cornerRadius = 45/2
        aView.center = CGPoint(x: view.center.x, y: aMaxHeight-2*aPadding)
        view.addSubview(aView)
        
        let aBar = UIView(frame: CGRect(x: aView.frame.width/2-1, y: 0, width: 2, height: 45))
        aBar.backgroundColor = .red
        aView.addSubview(aBar)
        
        buttonChoice1.frame = CGRect(x: 0, y: 0, width: aView.frame.width/2-1, height: 45)
        buttonChoice1.tag = 1
        buttonChoice1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttonChoice1.setTitle(choiceNames[1], for: .normal)
        buttonChoice1.addTarget(self, action: #selector(buttonChoiceTapped), for: .touchUpInside)
        aView.addSubview(buttonChoice1)
        
        buttonChoice2.frame = CGRect(x: aBar.frame.maxX, y: 0, width: aView.frame.width-aBar.frame.maxX, height: 45)
        buttonChoice2.tag = 2
        buttonChoice2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttonChoice2.setTitle(choiceNames[2], for: .normal)
        buttonChoice2.addTarget(self, action: #selector(buttonChoiceTapped), for: .touchUpInside)
        aView.addSubview(buttonChoice2)

    }
    
    
    func scrub() {
        player.currentTime = Double(scrubSlider.value)
    }

    
    func buttonChoiceTapped(sender: UIButton) {
        print(sender.tag)
        
        self.navigationItem.title = choiceNames[sender.tag]
        
        player.stop()
        timer.invalidate()
        playButton.setTitle("Play", for: .normal)
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: filePrefix+fileNames[sender.tag], ofType: type)!))
            
        }catch {
            print("Error!")
        }
    
        scrubSlider.maximumValue = Float(player.duration)
        scrubSlider.value = Float(player.currentTime)
        timerLabel.text = "\(stringFromTimeInterval(interval: player.currentTime))/\(stringFromTimeInterval(interval: player.duration))"

        sender.setTitle(choiceNames[choice], for: .normal)
        let temp  = choice
        choice = sender.tag
        sender.tag = temp
    
    }
    
    
    func updateScrubSlider(){
        
        scrubSlider.value = Float(player.currentTime)
        timerLabel.text = "\(stringFromTimeInterval(interval: player.currentTime))/\(stringFromTimeInterval(interval: player.duration))"
        
        if !player.isPlaying {
            playButton.setTitle("Play", for: .normal)
            timer.invalidate()
        }
    }
    
        
    func playTapped() {
        
        if player.isPlaying {
            player.pause()
            timer.invalidate()
            playButton.setTitle("Play", for: .normal)
        } else {
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubSlider), userInfo: nil, repeats: true)
            playButton.setTitle("Pause", for: .normal)
        }
    }
    

    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)

        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}
