//
//  MainViewController.swift
//  Magic8Ball
//
//  Created by mac on 22.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var ballImageView: UIImageView!
    
    private var isBallUp = true {
        didSet {
            rotateBall()
            requestAnswer()
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
    
    func requestAnswer() {
        guard !isBallUp else {
            return
        }
        
        if Reachability.isConnectedToNetwork() {
            NetworkManager.getMagicAnswer { answer in
                print(answer)
            }
        } else {
            print("default answer")
        }
    }
}
