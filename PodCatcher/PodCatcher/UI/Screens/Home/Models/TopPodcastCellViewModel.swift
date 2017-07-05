import UIKit

struct TopPodcastCellViewModel {
    
    var trackName: String
    var albumImageUrl: URL
    
    init(trackName: String, albumImageUrl: URL) {
        self.trackName = trackName
        self.albumImageUrl = albumImageUrl
    }
}