//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/18/23.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let collectionViewInset: Double = 5

    private var viewModel = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionViewLayout()
        viewModel.delegate = self
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

    @IBAction func resetButtonPressed(_ sender: Any) {
        viewModel.resetGame()
        collectionView.reloadData()
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
            print("CONGRATS \(player)".uppercased())
        case .tie:
            print("OH NO! IT'S A TIE")
        case .idle:
            break
        }
    }
}


