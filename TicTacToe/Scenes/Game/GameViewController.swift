//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/18/23.
//

import UIKit
import Lottie
import QuartzCore

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let collectionViewInset: Double = 5

    private var viewModel = Game()
    private var animationView: LottieAnimationView?
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 1
        return label
    }()

    enum AnimationType: String {
        case confetti = "Confetti"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionViewLayout()
        setupLabel()
        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.updateConstraints()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { (_) in
            self.setupCollectionViewLayout()
        }
        super.viewWillTransition(to: size, with: coordinator)
    }

    func setupNavBar() {
        let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(settingsButtonSelected))

        let resetButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetButtonPressed))

        navigationItem.leftBarButtonItem = settingsButtonItem
        navigationItem.rightBarButtonItem = resetButtonItem
    }

    @objc func settingsButtonSelected() {
        guard let settingsViewController = storyboard?.instantiateViewController(withIdentifier: SettingsViewController.id) else { return }
        present(settingsViewController, animated: true)
        print("settings")
    }

    @objc func resetButtonPressed() {
        viewModel.resetGame()
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
        hideLabel()
    }


    func setupLabel() {
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showLabel(for state: GameState) {
        resultLabel.isHidden = false
        UIView.animate(withDuration: 1.5) {
            self.resultLabel.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }
        collectionView.layer.opacity = 0.2

        switch state {
        case .playerWins(let player):
            resultLabel.text = "Congrats! 🥳"
        case .tie:
            resultLabel.text = "Oh no! It's a tie! ☹️"
        case .idle:
            break
        }
    }

    func hideLabel() {
        resultLabel.isHidden = true
        collectionView.layer.opacity = 10
        self.resultLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
    }

    func presentAnimation(_ loaderAnimation: AnimationType) {
        tabBarController?.tabBar.isHidden = true
        animationView?.isHidden = false

        animationView = .init(name: loaderAnimation.rawValue)

        guard let animationView = animationView else { return }

        animationView.frame = view.bounds
        animationView.contentMode = .center
        animationView.loopMode = .repeat(1.0)
        animationView.animationSpeed = 0.6
        animationView.isUserInteractionEnabled = false
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        animationView.play()
    }


    private func setupCollectionViewLayout() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: collectionViewInset, bottom: 0, right: -collectionViewInset)
        collectionView.updateConstraints()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(
            width: .fractionalWidth(1),
            height: .fractionalHeight(1),
            spacing: 5)

        let gridSize: CGFloat = {
            let width = view.frame.width - (view.safeAreaInsets.right + view.safeAreaInsets.left) - (collectionViewInset * 2)
            print("width \(width)")
            let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
            print("height \(height)")

            let smallestSize = min(width, height)

            return smallestSize
        }()
        print(gridSize)

        let group = CompositionalLayout.createGroup(
            alignment: .horizontal,
            width: .absolute(gridSize),
            height: .absolute(gridSize / Double(viewModel.getNumberOfRowsOnGrid())),
            item: item,
            count: viewModel.getNumberOfRowsOnGrid())

        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        let groupHeight = gridSize

        let section = NSCollectionLayoutSection(group: group)
        let currentOrientation = UIDevice.current.orientation

//        switch currentOrientation {
//        case .portrait, .portraitUpsideDown:
//            section.contentInsets = NSDirectionalEdgeInsets(top: (viewHeight - groupHeight) / 2, leading: 0, bottom: 0, trailing: 0)
//        case .landscapeLeft, .landscapeRight:
//            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: (viewWidth - groupHeight) / 2, bottom: 0, trailing: 0)
//        default:
//            section.contentInsets = NSDirectionalEdgeInsets(top: (viewHeight - groupHeight) / 2, leading: 0, bottom: 0, trailing: 0)
//        }

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension GameViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsOnGrid()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfRowsOnGrid()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        let item = viewModel.getItemOnGrid(
            position: Position(
                row: indexPath.section,
                column: indexPath.item)
        )

        let winnerCells = viewModel.getWinnerCells()

        cell.setup(indicator: item.player.symbol)

        for move in winnerCells {
            if indexPath.section == move.position.row &&
                indexPath.item == move.position.column {
                cell.fillWinnerCells(indicator: move.player.symbol)
            }
        }
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item: \(indexPath.item) \n section: \(indexPath.section) \n row: \(indexPath.row)")
        viewModel.playMove(Move(
            position: Position(row: indexPath.section, column: indexPath.item),
            player: viewModel.getCurrentPlayer()))

        collectionView.reloadData()
    }
}

extension GameViewController: GameStateDelegate {

    func didUpdate(with state: GameState) {
        switch state {
        case .playerWins(let player):
            collectionView.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.presentAnimation(.confetti)
                self.showLabel(for: .playerWins(player))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                guard let self = self else { return }
                self.hideLabel()
            }

            print("CONGRATS \(player)".uppercased())
        case .tie:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.collectionView.isUserInteractionEnabled = false
                self.showLabel(for: .tie)
            }
            print("OH NO! IT'S A TIE")
        case .idle:
            break
        }
    }
}


