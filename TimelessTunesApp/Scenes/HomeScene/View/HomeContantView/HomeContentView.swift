
import UIKit
import SnapKit

protocol IHomeContentView: UIView {
	var touchHandler: ((Int) -> Void)? { get set }
	func displayData(viewModel: HomeViewModel)
}

final class HomeContentView: UIView {
	
	var touchHandler: ((Int) -> Void)?

	private var adapter = HomeCollectionAdapter()
	private var collectionView: UICollectionView!
	private let emptyLabel = UIFactory.shared.makeLabel(
		font: .systemFont(
			ofSize: Constants.emptyLabelFontSize,
			weight: .medium
		),
		textColor: .gray,
		numberOfLines: Constants.numberOfLines
	)
	
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
		setupLabel()
	}
	
	func setupCollectionView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "listReuseIdentifier")
		collectionView.backgroundColor = UIColor(resource: .background)
		collectionView.dataSource = adapter
		collectionView.delegate = adapter
		adapter.onTap = { [weak self] index in
			self?.touchHandler?(index)
		}
		addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}

	func createLayout() -> UICollectionViewLayout {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(Constants.itemFractionalWidth),
			heightDimension: .absolute(Constants.itemAbsoluteHeight)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(Constants.groupAbsoluteHeight)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		group.interItemSpacing = .fixed(Constants.interItemSpacing)

		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(
			top: Constants.sectionInsetTop,
			leading: Constants.sectionInsetHorizontal,
			bottom: Constants.sectionInsetBottom,
			trailing: Constants.sectionInsetHorizontal
		)

		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func setupLabel() {
		emptyLabel.text = Constants.emptyLabelText
		emptyLabel.textAlignment = .center
		emptyLabel.isHidden = false
		addSubview(emptyLabel)
		
		emptyLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}

extension HomeContentView: IHomeContentView {
	func displayData(viewModel: HomeViewModel) {
		adapter.viewModel = viewModel
		
		emptyLabel.isHidden = !viewModel.cells.isEmpty
		collectionView.reloadData()
	}
}
