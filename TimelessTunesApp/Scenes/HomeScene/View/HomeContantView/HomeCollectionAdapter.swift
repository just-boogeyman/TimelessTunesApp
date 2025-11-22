
import UIKit

final class HomeCollectionAdapter: NSObject {
	
	var viewModel: HomeViewModel = HomeViewModel(cells: [])
	var onTap: ((Int) -> Void)?
	private let reuseIdentifier = "listReuseIdentifier"
}

extension HomeCollectionAdapter: UICollectionViewDataSource {

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
		cell.configure(viewModel: viewModel.cells[indexPath.row])
		return cell
	}
}

extension HomeCollectionAdapter: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		onTap?(indexPath.row)
	}
}
