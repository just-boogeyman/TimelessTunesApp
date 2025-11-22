
import Foundation
import CoreData

protocol ICoreDataHistoryManager {
	func loadTracks() -> [HistoryTrack]
	func saveTrack(value: MediaItem)
	func deleteTrack(for index: Int)
}

protocol ICoreDataFavoriteManager {
	func loadTracksFavorite() -> [HistoryTrack]
	func deleteCompany(for index: Int)
}

final class CoreDataManager {
	
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "TrackData")
		container.loadPersistentStores { _, error in
			_ = error.map { fatalError("Unresolved error \($0)") }
		}
		return container
	}()
	
	private var mainContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	private func saveContext() {
		try? mainContext.save()
	}
	
	private func checkTrack(id: Int) -> Bool {
		let request: NSFetchRequest<HistoryTrack> = HistoryTrack.fetchRequest()
		request.predicate = NSPredicate(format: "id == %d", id)

		if let existing = try? mainContext.fetch(request), !existing.isEmpty {
			return false
		}
		return true
	}
	
	private func loadData() -> [HistoryTrack] {
		do {
			let request: NSFetchRequest<HistoryTrack> = HistoryTrack.fetchRequest()
			return try self.mainContext.fetch(request)
		} catch {
			return []
		}
	}
}

extension CoreDataManager: ICoreDataHistoryManager {
	func loadTracks() -> [HistoryTrack] {
		loadData()
	}
	
	func saveTrack(value: MediaItem) {
		if checkTrack(id: value.id) {
			let track = HistoryTrack(context: mainContext)
			track.trackName = value.trackName
			track.artistName = value.artistName
			track.artworkUrl = value.artworkUrl
			track.previewUrl = value.previewUrl
			track.id = Int64(value.id)
			saveContext()
		}
	}
	
	func deleteTrack(for index: Int) {
		let track = loadTracks()[index]
		mainContext.delete(track)
		saveContext()
	}
}

extension CoreDataManager: ICoreDataFavoriteManager {
	func loadTracksFavorite() -> [HistoryTrack] {
		loadData()
	}
	
	func deleteCompany(for index: Int) {
		let track = loadTracks()[index]
		mainContext.delete(track)
		saveContext()
	}
}
