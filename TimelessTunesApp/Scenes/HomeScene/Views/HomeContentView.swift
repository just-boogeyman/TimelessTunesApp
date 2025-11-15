//
//  HomeContentView.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import UIKit
import SnapKit

protocol IHomeContentView: UIView {
	func displayData(viewModel: [HomeViewModel])
}

final class HomeContentView: UIView {
	
	private var viewModel: [HomeViewModel] = []
	
	private let reuseIdentifier = "listReuseIdentifier"
	private var collectionView: UICollectionView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

private extension HomeContentView {
	
	func setup() {
		backgroundColor = .lightGray
		setupCollectionView()
	}
	
	func setupCollectionView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.backgroundColor = UIColor(resource: .background)
		collectionView.dataSource = self
		collectionView.delegate = self
		addSubview(collectionView)

		collectionView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}
	
	func createLayout() -> UICollectionViewLayout {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5),
			heightDimension: .absolute(200)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(220)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		group.interItemSpacing = .fixed(25)
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
		return UICollectionViewCompositionalLayout(section: section)
	}
	
}

extension HomeContentView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifier,
			for: indexPath
		) as? HomeCollectionViewCell else {
			return UICollectionViewCell()
		}
		let cellViewModel = viewModel[indexPath.row]
		cell.configure(viewModel: cellViewModel)
		return cell
	}
	
	
}

extension HomeContentView: UICollectionViewDelegate {
	
}

extension HomeContentView: IHomeContentView {
	func displayData(viewModel: [HomeViewModel]) {
		self.viewModel = viewModel
		collectionView.reloadData()
	}
	
	
}
