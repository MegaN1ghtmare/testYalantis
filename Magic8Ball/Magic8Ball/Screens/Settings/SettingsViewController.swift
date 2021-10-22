//
//  SettingsViewController.swift
//  Magic8Ball
//
//  Created by mac on 23.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        setupView()
    }
}

// MARK: - private methods
private extension SettingsViewController {
    func setupView() {
        title = "Settings"
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let addAnswerButton = UIBarButtonItem(image: UIImage(systemName: "note.text.badge.plus"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(addAnswer))
        navigationItem.setRightBarButton(addAnswerButton, animated: false)
    }
    
    @objc func addAnswer() {
        print("add answer")
    }
}
