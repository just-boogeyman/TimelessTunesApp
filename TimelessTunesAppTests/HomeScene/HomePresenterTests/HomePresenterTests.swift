
import XCTest
@testable import TimelessTunesApp

final class HomePresenterTests: XCTestCase
{
	/**
	 Тест проверяет, что при вводе текста поиска презентер вызывает interactor.searchTracks с корректным параметром
	 
	 Вводные данные:
	 - `interactor.searchText` == `nil`
	 
	 Ожидаемый результат:
	 - `result` = `"searchText"`
	 */
	
	func test_presenter_didEnterSearch_interactorSearchTracks() {
		// Given
		let env = Environment()
		let presenter = env.makeSut()
		let searchText = "searchText"
		
		// When
		presenter.userDidEnterSearch(searchText: searchText)
		let result = env.interactor.searchText
		
		// Then
		XCTAssertEqual(result, searchText)
	}
	
	/**
	 Тест проверяет, что при запросе истории презентер вызывает interactor.loadHistoryTracks
	 
	 Вводные данные:
	 - `interactor.didCallLoadHistory` == `false`
	 
	 Ожидаемый результат:
	 - `result` = `True`
	 */
	func test_presenter_loadHistory_callsInteractor() {
		// Given
		let env = Environment()
		let presenter = env.makeSut()
		
		// When
		presenter.loadHistory()
		let result = env.interactor.didCallLoadHistory
		
		// Then
		XCTAssertTrue(result)
	}
	
	/**
	 Тест проверяет, что презентер корректно преобразует MediaItem в ViewModel и передаёт её во view
	 
	 Вводные данные:
	 - `view.viewModel` == `nil`
	 
	 Ожидаемый результат:
	 - `resultCount` = `1`
	 - `resultTrackName` = `Track`
	 */
	func test_presenter_presentData_updatesView() {
		// Given
		let env = Environment()
		let presenter = env.makeSut()
		let items = [
			MediaItem(id: 1,
					  artistName: "Artist",
					  trackName: "Track",
					  artworkUrl: "url",
					  previewUrl: "preview")
		]
		
		// When
		presenter.presentData(responce: items)
		let resultCount = env.view.viewModel?.cells.count
		let resultTrackName = env.view.viewModel?.cells.first?.trackName
		
		// Then
		XCTAssertEqual(resultCount, 1)
		XCTAssertEqual(resultTrackName, "Track")
	}
	
	/**
	 Тест проверяет, что при нажатии на ячейку презентер сохраняет трек в историю и инициирует навигацию

	 Вводные данные:
	 - `view.touchHandler` == `nil`
	 
	 Ожидаемый результат:
	 - `resultSavedTrack` = `Track`
	 - `resultReceivedIndex` = `0`
	 - `receivedItemsCount` = `1`
	 */
	func test_presenter_touchHandler_callsInteractorAndRouter() {
		// Given
		let env = Environment()
		let presenter = env.makeSut()
		let items = [
			MediaItem(id: 1,
					  artistName: "Artist",
					  trackName: "Track",
					  artworkUrl: "url",
					  previewUrl: "preview")
		]
		
		// When
		presenter.presentData(responce: items)
		env.view.touchHandler?(0)
		
		let resultSavedTrack = env.interactor.savedTrack?.trackName
		let resultReceivedIndex = env.router.receivedIndex
		let receivedItemsCount = env.router.receivedItems.count
		
		// Then
		XCTAssertEqual(resultSavedTrack, "Track")
		XCTAssertEqual(resultReceivedIndex, 0)
		XCTAssertEqual(receivedItemsCount, 1)
	}
}

extension HomePresenterTests
{
	final class Environment
	{
		let interactor = HomeInteractorInputMock()
		let router = HomeRouterMock()
		let view = HomeViewMock()
		let controller = HomeControllerMock()
		
		func makeSut() -> HomePresenter {
			let presenter = HomePresenter(
				interactor: interactor,
				router: router
			)
			presenter.loadView(controller: controller, view: view)
			return presenter
		}
	}
}
