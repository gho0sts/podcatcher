import UIKit

protocol PlaylistViewControllerDelegate: class {
    func didSelectPodcast(at index: Int, with episodes: [PodcastPlaylistItem])
}
