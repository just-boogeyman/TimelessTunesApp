//
//  HomeInteractor.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import Foundation


protocol IHomeInteractorInput {
	func searchTracks(searchText: String)
}

protocol IHomeInteractorOutput: AnyObject {
	func presentData(responce: [MediaItem])
	func didFail(error: Error)
}

final class HomeInteractor {
	
	private let networkService: INetworkService
	weak var output: IHomeInteractorOutput?
	 
	init(networkService: INetworkService) {
		self.networkService = networkService
	}

}

extension HomeInteractor: IHomeInteractorInput {
	func searchTracks(searchText: String) {
		networkService.loadData(form: .basic, ITunesSearchResponse.self, string: searchText) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let response):
				let entities = response.results.map { $0.toEntity() }
				output?.presentData(responce: entities)
			case .failure(let error):
				output?.didFail(error: error)
			}
		}
	}
	
	
}
