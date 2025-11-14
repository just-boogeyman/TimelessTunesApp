//
//  HomeRouter.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import UIKit

protocol BaseRouting {
	func setCurrentViewController()
	func setNextViewController()
}

protocol IHomeRouter {
	func next()
}

final class HomeRouter {
	private var currentController: UIViewController?
	private var nextController: UIViewController?
}

extension HomeRouter: IHomeRouter {
	func next() {
		print("hello")
	}
}
