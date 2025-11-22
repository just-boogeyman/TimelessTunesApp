
import Foundation
import CoreData


extension HistoryTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryTrack> {
        return NSFetchRequest<HistoryTrack>(entityName: "HistoryTrack")
    }

    @NSManaged public var artistName: String
    @NSManaged public var trackName: String
    @NSManaged public var artworkUrl: String
    @NSManaged public var previewUrl: String
    @NSManaged public var id: Int64

}

extension HistoryTrack : Identifiable {

}
