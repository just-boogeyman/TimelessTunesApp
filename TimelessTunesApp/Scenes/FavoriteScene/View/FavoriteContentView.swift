import UIKit
import SnapKit

protocol IFavoriteContentView: UIView {
	var nextHandler: ((Int) -> Void)? { get set }
	var deletedHandler: ((Int) -> Void)? { get set }
	func render(items: [UUID])
}

final class FavoriteContentView: UIView {
	
	private let tableView = UITableView()
	private let tableHandler = FavoriteTableHandler()
	
	var nextHandler: ((Int) -> Void)? {
		didSet { tableHandler.nextHandler = nextHandler }
	}
	var deletedHandler: ((Int) -> Void)? {
		didSet { tableHandler.deletedHandler = deletedHandler }
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension FavoriteContentView {
	
	func setupView() {
		setupTableView()
		setupConstraint()
	}
	
	func setupTableView() {
		addSubview(tableView)
		tableView.backgroundColor = .darkGray
		tableView.dataSource = tableHandler
		tableView.delegate = tableHandler
	}
	
	func setupConstraint() {
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func configureCell(_ cell: UITableViewCell, index: UUID) {
		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.text = "\(index)"
		contentConfiguration.textProperties.color = .white
		cell.contentConfiguration = contentConfiguration
		cell.backgroundColor = .darkGray
		cell.selectionStyle = .none
	}
}

extension FavoriteContentView: IFavoriteContentView {
	func render(items: [UUID]) {
		self.tableHandler.update(items)
		self.tableView.reloadData()
	}
}
