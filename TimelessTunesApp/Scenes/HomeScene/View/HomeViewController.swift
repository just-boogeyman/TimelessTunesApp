
import UIKit

protocol IHomeViewController: AnyObject {}

final class HomeViewController: UIViewController, IHomeViewController {
	
	private let contentView: IHomeContentView
	private let presenter: IHomePresenter
	private let searchController = UISearchController(searchResultsController: nil)
	private var timer: Timer?
	
	private var isFiltering: Bool {
		searchController.searchBar.selectedScopeButtonIndex != 0
	}
	
	init(presenter: IHomePresenter) {
		self.contentView = HomeContentView()
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = contentView
		presenter.loadView(controller: self, view: contentView)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

private extension HomeViewController {
	
	func setup() {
		title = Constants.screenTitle
		view.backgroundColor = .white
		setupSearchController()
		setupScopeBar()
		setupThemeToggleButton()
	}
	
	func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = Constants.searchPlaceholder
		searchController.searchBar.barTintColor = Constants.searchBarBarTintColor
		searchController.searchBar.tintColor = Constants.searchBarTintColor
		searchController.searchBar.searchBarStyle = .minimal
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
	}
	
	func setupScopeBar() {
		let scopeBarAppearance = UISearchBar.appearance()
		scopeBarAppearance.setScopeBarButtonTitleTextAttributes(
			[.foregroundColor: Constants.scopeButtonTextColor], for: .normal)
		
		searchController.searchBar.scopeButtonTitles = [Constants.scopeSearch, Constants.scopeHistory]
		searchController.searchBar.delegate = self
	}
	
	func setupThemeToggleButton() {
		let button = UIBarButtonItem(
			title: Constants.themeButtonTitle,
			style: .plain,
			target: self,
			action: #selector(toggleTheme)
		)
		navigationItem.rightBarButtonItem = button
	}
	
	@objc private func toggleTheme() {
		searchController.searchBar.tintColor =
			(searchController.searchBar.tintColor == Constants.themeColor1)
			? Constants.themeColor2
			: Constants.themeColor1
	}
}

extension HomeViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		if searchController.isActive {
			searchBar.setShowsScope(true, animated: true)
		}
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchController.isActive {
			searchBar.selectedScopeButtonIndex = 0
		}
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: Constants.searchDelay, repeats: false) { [weak self] _ in
			self?.presenter.userDidEnterSearch(searchText: searchText)
		}
	}
	
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		if isFiltering {
			searchController.searchBar.text = ""
			presenter.loadHistory()
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		if searchController.isActive {
			searchBar.showsScopeBar = false
			searchBar.selectedScopeButtonIndex = 0
		}
	}
}

private extension HomeViewController {
	enum Constants {
		static let screenTitle = "Вечные хиты"
		static let searchPlaceholder = "Поиск"
		static let themeButtonTitle = "Сменить тему"
		
		static let scopeSearch = "Поиск"
		static let scopeHistory = "История"
		
		static let searchDelay: TimeInterval = 1.0
		
		static let searchBarBarTintColor = UIColor.white
		static let searchBarTintColor = UIColor.darkGray
		static let scopeButtonTextColor = UIColor.gray
		static let themeColor1 = UIColor.darkText
		static let themeColor2 = UIColor.blue
	}
}
