//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/18/23.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var isHumanTurn: Bool = true
    private let collectionViewInset: Double = 5
    var count = 0

    private var viewModel = GameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionViewLayout()
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

    private func checkWinner(player: Player) -> Bool {
        var winPatterns: Set<Set<Int>> = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            [1, 5, 9],
            [3, 5, 7],
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9]
        ]

        return false
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
            height: .absolute(gridSize / Double(viewModel.getNumberOfRows())),
            item: item,
            count: viewModel.getNumberOfRows())

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
        return viewModel.getNumberOfRows()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        let item = viewModel.getItemOnGrid(
            row: indexPath.row,
            section: indexPath.section
        )
        cell.setup(indicator: item.player.symbol)
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        count += 1

        viewModel.playMove(position: (indexPath.row, indexPath.section), for: viewModel.getCurrentPlayer())
        collectionView.reloadData()
    }
}

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!

    func setup(indicator: String) {
        backgroundColor = UIColor(red: 0.92, green: 0.47, blue: 0.44, alpha: 1.00)
        layer.cornerRadius = 25
        cellImageView.image = UIImage(systemName: indicator)
        cellImageView.tintColor = .white
    }
}
