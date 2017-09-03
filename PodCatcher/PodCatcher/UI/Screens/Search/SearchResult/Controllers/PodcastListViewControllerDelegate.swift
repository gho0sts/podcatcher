import UIKit

protocol PodcastListViewControllerDelegate: class {
    func didSelectPodcastAt(at index: Int, podcast: CasterSearchResult, with episodes: [Episodes])
    func saveFeed(item: CasterSearchResult, podcastImage: UIImage, episodesCount: Int) 
}

