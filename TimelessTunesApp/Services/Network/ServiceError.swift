
import Foundation

enum ServiceError: Error {
	case invalidURL
	case noData
	case networkError(Error)
	case parsingError(Error)
}
