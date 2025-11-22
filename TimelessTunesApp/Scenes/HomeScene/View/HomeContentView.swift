
import UIKit
import SnapKit

protocol IHomeContentView: UIView {
	var touchHandler: ((Int) -> Void)? { get set }
	func displayData(viewModel: HomeViewModel)
}

final class HomeContentView: UIView {
	
	var touchHandler: ((Int) -> Void)?

	private var viewModel = HomeViewModel(cells: [])
	private let reuseIdentifier = "listReuseIdentifier"
	private var collectionView: UICollectionView!
	private let emptyLabel = UILabel()
	
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
	
	func setupLabel() {
		emptyLabel.text = "Найдите свой лучший трек"
		emptyLabel.font = .systemFont(ofSize: 18, weight: .medium)
		emptyLabel.textColor = .gray
		emptyLabel.textAlignment = .center
		emptyLabel.isHidden = false
		addSubview(emptyLabel)
		emptyLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}

extension HomeContentView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.cells.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifier,
			for: indexPath
		) as? HomeCollectionViewCell else {
			return UICollectionViewCell()
		}
		let cellViewModel = viewModel.cells[indexPath.row]
		cell.configure(viewModel: cellViewModel)
		return cell
	}
	
}

extension HomeContentView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		touchHandler?(indexPath.row)
	}
}

extension HomeContentView: IHomeContentView {
	func displayData(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		emptyLabel.isHidden = !viewModel.cells.isEmpty
		collectionView.reloadData()
	}
}
