
import UIKit

final class FavoriteTableHandler: NSObject {
	
	private var items: [FavoriteEntity] = []
	var nextHandler: ((Int) -> Void)?
	var deletedHandler: ((Int) -> Void)?
	
	func update(_ items: [FavoriteEntity]) {
		self.items = items
	}
}

extension FavoriteTableHandler: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var config = cell.defaultContentConfiguration()
		config.text = items[indexPath.row].artistName
		config.textProperties.color = .black
		config.secondaryText = items[indexPath.row].trackName
		config.secondaryTextProperties.color = .darkGray
		cell.contentConfiguration = config
		cell.backgroundColor = .white
		cell.selectionStyle = .none
		return cell
	}
}

extension FavoriteTableHandler: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.nextHandler?(indexPath.row)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .delete
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			items.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			self.deletedHandler?(indexPath.row)
		}
	}
	
}
