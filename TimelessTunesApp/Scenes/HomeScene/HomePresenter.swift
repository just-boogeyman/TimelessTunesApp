//
//  HomePresenter.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import Foundation

protocol IHomePresenter {
	func loadView(controller: IHomeViewController, view: IHomeContentView)
}

final class HomePresenter {
	
	private weak var controller: IHomeViewController?
	private weak var view: IHomeContentView?
	private let router: IHomeRouter
	
	init(router: IHomeRouter) {
		self.router = router
	}
	
}

extension HomePresenter: IHomePresenter {
	func loadView(controller: IHomeViewController, view: IHomeContentView) {
		self.controller = controller
		self.view = view
	}
}
