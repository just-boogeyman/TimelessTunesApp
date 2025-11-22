
import UIKit

final class FavoriteTableHandler: NSObject {
	
	private var items: [UUID] = []
	var nextHandler: ((Int) -> Void)?
	var deletedHandler: ((Int) -> Void)?
	
	func update(_ items: [UUID]) {
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
		config.text = items[indexPath.row].uuidString
		config.textProperties.color = .white
		cell.contentConfiguration = config
		cell.backgroundColor = .darkGray
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
			self.deletedHandler?(indexPath.row)
			items.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
}
