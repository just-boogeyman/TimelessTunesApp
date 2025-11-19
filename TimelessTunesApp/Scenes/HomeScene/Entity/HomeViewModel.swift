//
//  HomeViewModel.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 15.11.2025.
//

import Foundation

struct HomeViewModel {
	struct Cell: ITrackCellViewModel {
		var iconUrlString: String?
		var trackName: String
		var artistName: String
		var collectionName: String
		let previewUrl: String?
	}
	
	let cells: [Cell]
}
