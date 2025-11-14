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
		let router: IHomeRouter
	}
	
	static func assembly(dependencies: Dependencies) -> UIViewController {
		
		let presenter = HomePresenter(router: dependencies.router)
		let viewController = HomeViewController(presenter: presenter)
		
		return viewController
	}
}
