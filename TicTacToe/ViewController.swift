//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/18/23.
//

import UIKit

enum Player {
    case human, computer
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var isHumanTurn: Bool = true
    private var moves: [Move?] = Array(repeating: nil, count: 9)
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionViewLayout()
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        resetGame()
    }

    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
    }

    private func isOccupied(index: Int) -> Bool {
        return moves.contains { $0?.boardIndex == index }
    }

    private func resetGame() {
        moves = Array(repeating: nil, count: 9)
        collectionView.reloadData()
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
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moves.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//
        if let move = moves[indexPath.item] {
            cell.setup(indicator: move.indicator)
        } else {
            cell.setup(indicator: "")
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        count += 1
        print("selected \(count)")
        if isOccupied(index: indexPath.item) { return }
        let player: Player = isHumanTurn ? .human : .computer

        moves[indexPath.item] = Move(player: player, boardIndex: indexPath.item)

        isHumanTurn.toggle()
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let width = totalWidth / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalHeight = collectionView.frame.height
        let cellHeight = collectionView.frame.width / 4

        let insetHeight = (totalHeight - (3 * cellHeight)) / 2
        return UIEdgeInsets(
            top: insetHeight,
            left: 24,
            bottom: insetHeight,
            right: 24)
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
