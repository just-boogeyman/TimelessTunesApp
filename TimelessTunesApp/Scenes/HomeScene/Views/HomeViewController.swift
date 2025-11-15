//
//  HomeViewController.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 13.11.2025.
//

import UIKit

protocol IHomeViewController: AnyObject {}

final class HomeViewController: UIViewController, IHomeViewController {

	private let contentView: IHomeContentView
	private let presenter: IHomePresenter
	private let searchController = UISearchController(searchResultsController: nil)
	private var timer: Timer?
	
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
		title = "TimelessTunesApp"
		view.backgroundColor = UIColor(resource: .background)
		setupSearchController()
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
}

// MARK: - UISearchResultsUpdating

extension HomeViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		print("Go")
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
			self?.presenter.userDidEnterSearch(searchText: searchText)
		}
	}
}
