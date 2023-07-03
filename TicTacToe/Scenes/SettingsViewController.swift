//
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 6/21/23.
//

import UIKit

class SettingsViewController: UIViewController {
    static let id = "SettingViewController"

    var viewModel: Game!
    var gridSize: Int?
    lazy var level: GameLevel = viewModel.gameLevel ?? .easy

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!

    lazy var buttons: [UIButton] = [easyButton, mediumButton, hardButton]

    override func viewDidLoad() {
        title = "Game Level"

        setupNavBar()
        switch level {
        case .easy:
            disableButton(easyButton)
        case .medium:
            disableButton(mediumButton)
        case .hard:
            disableButton(hardButton)
        }
    }

    func setupNavBar() {
        navigationController?.navigationBar.backgroundColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapBackButton))
    }

    @objc func didTapBackButton() {
        dismiss(animated: true)
    }

    @IBAction func easyButtonPressed(_ sender: Any) {
        level = .easy
        disableButton(easyButton)
    }

    @IBAction func mediumButtonPressed(_ sender: Any) {
        level = .medium
        disableButton(mediumButton)
    }

    @IBAction func hardButtonPressed(_ sender: Any) {
        level = .hard
        disableButton(hardButton)
    }

    private func disableButton(_ TappedButton: UIButton) {
        buttons.forEach { button in
            button.isEnabled = TappedButton != button
        }
    }

    @IBAction func didTapDoneButton(_ sender: UIButton) {
        Alert.showBasics(
            title: "This action will restart your game",
            message: "Are you sure you want to continue?",
            vc: self) { 
                self.dismiss(animated: true)
                self.viewModel.updateNumberOfRowsOnGrid(for: self.level)
            }
    }
}
