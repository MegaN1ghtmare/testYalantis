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
        setupTableView()
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Constants.defaultAnswers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Constants.defaultAnswers[indexPath.item]
        
        return cell
    }
}
