//
//  MainViewController.swift
//  Magic8Ball
//
//  Created by mac on 22.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var ballImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
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
        
        setupView()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            isBallUp.toggle()
        }
    }
}

// MARK: - private methods
private extension MainViewController {
    func setupView() {
        title = "Shake that ball!"
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let openSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(openSettings))
        navigationItem.setRightBarButton(openSettingsButton, animated: false)
    }
    
    @objc func openSettings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func rotateBall() {
        if isBallUp {
            ballImageView.image = UIImage(named: "ballWith8")
        } else {
            ballImageView.image = UIImage(named: "emptyBall")
        }
    }
    
    func requestAnswer() {
        guard !isBallUp else {
            answerLabel.text = nil
            return
        }
        
        if Reachability.isConnectedToNetwork(),
           !Constants.useDefaultAnswersPermanently {
            NetworkManager.getMagicAnswer { [weak self] response in
                DispatchQueue.main.async {
                    if let answer = response {
                        self?.answerLabel.text = answer
                    } else {
                        self?.showDefaultAnswer()
                    }
                }
            }
        } else {
            showDefaultAnswer()
        }
    }
    
    func showDefaultAnswer() {
        answerLabel.text = Constants.defaultAnswers.randomElement()
    }
}
