//
//  HomePresenter.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import Foundation

protocol IHomePresenter {
	func loadView(controller: IHomeViewController, view: IHomeContentView)
	func userDidEnterSearch(searchText: String)
}

final class HomePresenter {
	
	private weak var controller: IHomeViewController?
	private weak var view: IHomeContentView?
	private let interactor: IHomeInteractorInput
	private let router: IHomeRouter
	
	init(interactor: IHomeInteractorInput, router: IHomeRouter) {
		self.interactor = interactor
		self.router = router
	}
	
	private func cellViewModel(from track: MediaItem) -> HomeViewModel {
		HomeViewModel(iconUrlString: track.artworkUrl, trackName: track.trackName, artistName: track.artistName)
	}
	
}

extension HomePresenter: IHomePresenter {
	func userDidEnterSearch(searchText: String) {
		interactor.searchTracks(searchText: searchText)
	}
	
	func loadView(controller: IHomeViewController, view: IHomeContentView) {
		self.controller = controller
		self.view = view
	}
}

extension HomePresenter: IHomeInteractorOutput {
	func presentData(responce: [MediaItem]) {
		let viewModel = responce.map { cellViewModel(from: $0) }
		view?.displayData(viewModel: viewModel)
	}
	
	func didFail(error: Error) {
		print(error)
	}
}
