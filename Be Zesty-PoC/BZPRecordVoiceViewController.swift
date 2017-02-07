//
//  BZPRecordVoiceViewController.swift
//  Be Zesty-PoC
//
//  Created by Aditya Vikram Godawat on 07/02/17.
//  Copyright © 2017 Wow Labz. All rights reserved.
//

import UIKit
import AVFoundation

class BZPRecordVoiceViewController: UIViewController {

    // MARK: - Outlets
    
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "Record Your Thoughts"
        
        setupView()
    }

    
    func setupView() {
        // Variables
        let aPadding = CGFloat(30)
        let aMaxWidth = self.view.frame.width
        let aMaxHeight = self.view.frame.height

    }
    
}
