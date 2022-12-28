//
//  TestDiffableViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/28.
//

import UIKit

class TestDiffableViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    private let drinksController = DrinksController()
    private let searchBar = UISearchBar(frame: .zero)
    private var drinksCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DrinksController.Drink>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Drinks Search"
        configureHierachy()
        configureDataSource()
        performQuery(with: nil)
    }
    
    // 초기 DataSource 설정
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <LabelCollectionViewCell, DrinksController.Drink> { (cell, indexPath, drinks) in
            cell.label.text = drinks.name
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DrinksController.Drink>(collectionView: drinksCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DrinksController.Drink) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    /* SearchBar - textDidChange 발생시 query 실행
     1. NSDiffableDataSourceSnapshot 생성.
        - 처음에는 비어 있음. 따라서 원하는 섹션과 항목으로 채워야 함.
     2. Snapshot에 Sections과 Items 추가
        - 이 경우, 하나의 섹션을 가진 UICollectionView이므로, main 하나만 추가
        - 업데이트에 표시하려는 항목들의 식별자를 추가
        - Swift의 기본 유형 뿐만이 아니라, 고유한 타입으로 작업할 수도 있음. 구조체같은 값 유형일 경우, 해당 유형을 Hashable하게 만들면 Swift 구문 측면에서 고유한 기본 개체를 전달할 수 있음.
     3. DiffableDataSource를 호출하고 차이점을 애니메이션화 하여 해당 Snapshot을 적용하도록 요청 - apply()
     */
    private func performQuery(with filter: String?) {
        // 1. SearchBar text를 사용해서 filter 작업
        let drinks = drinksController.filteredDrinks(with: filter).sorted{ $0.name < $1.name }
        
        // 2. snapshot 생성 후 filter 작업 거친 drinks를 append
        var snapshot = NSDiffableDataSourceSnapshot<Section, DrinksController.Drink>()
        snapshot.appendSections([.main])
        snapshot.appendItems(drinks)
        // 3. 그 후 dataSource에 snapshot 적용
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension TestDiffableViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            return section
        }
        return layout
    }
    
    private func configureHierachy() {
        view.backgroundColor = .systemBackground
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        let views = ["cv": collectionView, "searchBar": searchBar]
        var constraint = [NSLayoutConstraint]()
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[cv]|", metrics: nil, views: views))
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchBar]|", metrics: nil, views: views))
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[searchBar]-20-[cv]|", metrics: nil, views: views))
        constraint.append(searchBar.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0))
        NSLayoutConstraint.activate(constraint)
        drinksCollectionView = collectionView
        searchBar.delegate = self
    }
}

extension TestDiffableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
