//
//  ViewController.swift
//  Collection View Nested Group with Nib
//
//  Created by Artemy Ozerski on 19/06/2022.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView! = nil
    var dataSource : UICollectionViewDiffableDataSource<Section, Int>! = nil
    enum Section{
        case main
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }


}

extension ViewController{
    private func createLayout()-> UICollectionViewLayout{
//MARK: - items
        let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                    heightDimension: .fractionalHeight(1.0))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)

        let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.3))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)

//MARK: - Group

        let secondGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                     heightDimension: .fractionalHeight(1.0))

        let secondGroup = NSCollectionLayoutGroup.vertical(layoutSize: secondGroupSize, subitem: trailingItem, count: 2)

        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                heightDimension: .fractionalHeight(0.4)),
                                                                                                subitems: [leadingItem, secondGroup])
//MARK: - Section

        let section = NSCollectionLayoutSection(group: nestedGroup)

        return UICollectionViewCompositionalLayout(section: section)

    }
    private func configureHierarchy(){

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(collectionView)

    }
    private func configureDataSource(){
        //IN CASE: you don't want to use NIBS see below

//        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { cell, indexPath, itemIdentifier in
//            cell.label.text = "\(indexPath)"
//            cell.layer.borderWidth = 1.0
//            cell.layer.borderColor = UIColor.label.cgColor
//        }
//        let cellRegistration = UICollectionView.CellRegistration(cellNib: UINib(nibName: "nibCell", bundle: nil)) { (cell : nibCell, indexPath: IndexPath, itemIdentifier: Int) in
//           // cell.labelOutlet.text = "\(indexPath)"
//            cell.layer.borderWidth = 1.0
//            cell.layer.borderColor = UIColor.label.cgColor
//        }
        let cellRegistration = UICollectionView.CellRegistration<nibCell, Int>(cellNib: UINib(nibName: "nibCell", bundle: nil)) { cell , indexPath, itemIdentifier in
            cell.labelOutlet.text = "\(itemIdentifier)"
            cell.layer.borderWidth = 1
        }
        dataSource = UICollectionViewDiffableDataSource <Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier: Int)-> UICollectionViewCell in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibCell.reuseIdentifier, for: indexPath)
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...39))
        dataSource.apply(snapshot)
    }

}
//    ______      ______
//   |      |    |      |
//   |      |    |      |
//   |      |    |______|
//   |      |     ______
//   |      |    |      |
//   |______|    |      |
//               |______|


