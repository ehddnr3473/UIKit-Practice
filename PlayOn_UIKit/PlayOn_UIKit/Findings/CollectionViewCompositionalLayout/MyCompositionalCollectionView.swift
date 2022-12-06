//
//  MyCollectionViewCompositionalLayout.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/06.
//

import UIKit

class MyCompositionalCollectionView: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.contentInset = .zero
        
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemInset: CGFloat = 2.5
        
        let fullWidthItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .fractionalHeight(1/3)))
        fullWidthItem.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        let rowTwoColOne = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                                                heightDimension: .fractionalHeight(1.0)))
        rowTwoColOne.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        let rowTwoColTwoItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .fractionalHeight(0.5)))
        rowTwoColTwoItem.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        
        let rowTwoColTwoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                                            heightDimension: .fractionalHeight(1.0)),
                                                         repeatingSubitem: rowTwoColTwoItem,
                                                         count: 2)
        
        
        let rowTwoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                heightDimension: .fractionalHeight(1/3)),
                                                             subitems: [rowTwoColOne, rowTwoColTwoGroup])
        
        let rowThreeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                                       heightDimension: .fractionalHeight(1.0)))
        rowThreeItem.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        let rowThreeGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)), repeatingSubitem: rowThreeItem, count: 3)
        
        let groupOfGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [fullWidthItem, rowTwoGroup, rowThreeGroup])
        
        let section = NSCollectionLayoutSection(group: groupOfGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        configure()
    }
    
    private func configure() {
        collectionView.dataSource = self
    }
}

extension MyCompositionalCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ModelData.emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell else { return UICollectionViewCell() }
        
        cell.emojiLabel.text = ModelData.emojis[indexPath.row]
        
        return cell
    }
}

//#if DEBUG
//
//import SwiftUI
//
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        // return ViewController
//        MyCompositionalCollectionView()
//    }
//}
//
//struct ViewControllerRepresentablePreviewProvider: PreviewProvider {
//    static var previews: some View {
//        ViewControllerRepresentable()
//    }
//}
//
//#endif
