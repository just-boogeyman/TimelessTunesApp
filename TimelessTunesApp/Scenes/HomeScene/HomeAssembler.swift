//
//  HomeAssembler.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import Foundation
import UIKit

enum HomeAssembler {
	
	struct Dependencies {
		let networkService: INetworkService
		let router: IHomeRouter
	}
	
	static func assembly(dependencies: Dependencies) -> UIViewController {
		
		let interactor = HomeInteractor(networkService: dependencies.networkService)
		let presenter = HomePresenter(interactor: interactor, router: dependencies.router)
		let viewController = HomeViewController(presenter: presenter)
		
		interactor.output = presenter
		return viewController
	}
}
