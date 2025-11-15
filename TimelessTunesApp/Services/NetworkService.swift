//
//  NetworkService.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import Foundation

enum Endpoint: String {
	
	case basic = "https://itunes.apple.com/search"
}

enum ServiceError: Error {
	case invalidURL
	case noData
	case networkError(Error)
	case parsingError(Error)
}

protocol INetworkService {
	func loadData<T: Decodable>(form endpoint: Endpoint, _ type: T.Type, string: String, completion: @escaping (Result<T, ServiceError>) -> Void)
}   

final class NetworkService: INetworkService {
	func loadData<T: Decodable>(form endpoint: Endpoint, _ type: T.Type, string: String, completion: @escaping (Result<T, ServiceError>) -> Void) {
		var components = URLComponents(string: endpoint.rawValue)
		components?.queryItems = [
			URLQueryItem(name: "entity", value: "musicTrack"),
			URLQueryItem(name: "term", value: string),
			URLQueryItem(name: "limit", value: "5")
		]
		guard let url = components?.url else {
			completion(.failure(.invalidURL))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(.networkError(error))) // Это например сетевая ошибка нету интернета или таймаут  (описание будет в error) дальше ее просто обработать достать и обработать то есть
				return
			}
			
			guard let data else {
				completion(.failure(.noData))
				return
			}
			
			do {
				let post = try JSONDecoder().decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(post))
				}
			} catch {
				completion(.failure(.parsingError(error))) // так же проверить что там в ошибке
			}
		}
		task.resume()
	}
}
