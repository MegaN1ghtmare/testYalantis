//
//  MainViewController.swift
//  Magic8Ball
//
//  Created by mac on 22.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var ballImageView: UIImageView!
    
    private var isBallUp = false {
        didSet {
            rotateBall()
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            isBallUp.toggle()
        }
    }
}

// MARK: - private methods
private extension MainViewController {
    func rotateBall() {
        if isBallUp {
            ballImageView.image = UIImage(named: "ballWith8")
        } else {
            ballImageView.image = UIImage(named: "emptyBall")
        }
    }
}
