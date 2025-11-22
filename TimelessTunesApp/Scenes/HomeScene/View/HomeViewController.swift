
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
		title = "Вечные хиты"
		view.backgroundColor = .white
		setupSearchController()
		setupScopeBar()
		setupThemeToggleButton()
	}
	
	func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Поиск"
		searchController.searchBar.barTintColor = .white
		searchController.searchBar.tintColor = .darkGray
		searchController.searchBar.searchBarStyle = .minimal
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
	}
	
	func setupScopeBar() {
		let scopeBarAppearance = UISearchBar.appearance()
		scopeBarAppearance.setScopeBarButtonTitleTextAttributes(
			[.foregroundColor: UIColor.gray], for: .normal)
			   
		searchController.searchBar.scopeButtonTitles = ["Поиск", "История"]
		searchController.searchBar.delegate = self
	}
	
	func setupThemeToggleButton() {
		let button = UIBarButtonItem(title: "Тема", style: .plain, target: self, action: #selector(toggleTheme))
		navigationItem.rightBarButtonItem = button
	}
	
	@objc private func toggleTheme() {
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
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
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
