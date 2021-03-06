//
//  ViewController.swift
//  Be Zesty-PoC
//
//  Created by Aditya Vikram Godawat on 01/02/17.
//  Copyright © 2017 Wow Labz. All rights reserved.
//

import UIKit

var _LANG_CODE = String()

class ViewController: UIViewController {

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = "Relax and Meditate"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

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
        
        let aDescriptionLabel = UILabel(frame: CGRect(x: aPadding, y: 3*aPadding, width: aMaxWidth-2*aPadding, height: 100))
        aDescriptionLabel.numberOfLines = 0
        aDescriptionLabel.text = "When words fail, music speaks.\nMusic is  the healing power of the universe.\nLet it help you meditate on your stronger side."
        aDescriptionLabel.textAlignment = .center
        aDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(aDescriptionLabel)
        
        let aButton  = UIButton(frame: CGRect(x: 0, y: 0, width: aMaxWidth-6*aPadding, height: 45))
        aButton.setTitle("Try Meditation", for: .normal)
        aButton.backgroundColor = .red
        aButton.layer.cornerRadius = 45/2
        aButton.center = CGPoint(x: view.center.x, y: aMaxHeight-4*aPadding)
        aButton.addTarget(self, action: #selector(listenToMusic), for: .touchUpInside)
        view.addSubview(aButton)
        
    }

    
    func listenToMusic() {
        
        let langCode = NSLocale.preferredLanguages[0]
        let index = langCode.index(langCode.startIndex, offsetBy: 2)
        _LANG_CODE = langCode.substring(to: index)
        print(_LANG_CODE)
        
        let aVC = BZPMusicViewController()
        self.navigationController?.pushViewController(aVC, animated: true)
        
    }
    
}
