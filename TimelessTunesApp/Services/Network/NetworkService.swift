import Foundation

protocol INetworkService {
	func loadData<T: Decodable>(
		form endpoint: Endpoint,
		_ type: T.Type,
		string: String,
		completion: @escaping (Result<T, ServiceError>
		) -> Void)
}

final class NetworkService: INetworkService {
	func loadData<T: Decodable>(
		form endpoint: Endpoint,
		_ type: T.Type,
		string: String,
		completion: @escaping (Result<T, ServiceError>
		) -> Void) {
		var components = URLComponents(string: endpoint.rawValue)
		components?.queryItems = [
			URLQueryItem(name: "entity", value: "musicTrack"),
			URLQueryItem(name: "term", value: string),
			URLQueryItem(name: "limit", value: "10")
		]
		guard let url = components?.url else {
			completion(.failure(.invalidURL))
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(.networkError(error)))
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
				completion(.failure(.parsingError(error)))
			}
		}
		task.resume()
	}
}
