import UIKit

final class SearchTabCoordinator: NavigationCoordinator {
    
    weak var delegate: CoordinatorDelegate?
    var type: CoordinatorType = .tabbar
    var dataSource: BaseMediaControllerDataSource!
    
    var childViewControllers: [UIViewController] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childViewControllers = navigationController.viewControllers
    }
    
    convenience init(navigationController: UINavigationController, controller: UIViewController) {
        self.init(navigationController: navigationController)
        navigationController.viewControllers = [controller]
    }
    
    func start() {
        let searchViewController = navigationController.viewControllers[0] as! SearchViewController
        searchViewController.delegate = self
    }
}

extension SearchTabCoordinator: SearchViewControllerDelegate {
    
    func logout(tapped: Bool) {
        delegate?.transitionCoordinator(type: .app, dataSource: dataSource)
    }
    
    func didSelect(at index: Int, with caster: PodcastSearchResult) {
        let searchViewController = navigationController.viewControllers[0] as! SearchViewController
        let resultsList = SearchResultListViewController(index: index)
        resultsList.delegate = self
        resultsList.dataSource = dataSource
        resultsList.item = caster as! CasterSearchResult
        guard let feedUrlString = resultsList.item.feedUrl else { return }
        let store = SearchResultsDataStore()
        let concurrent = DispatchQueue(label: "concurrentBackground",
                                       qos: .background,
                                       attributes: .concurrent,
                                       autoreleaseFrequency: .inherit,
                                       target: nil)
        concurrent.async { [weak self] in
            guard let strongSelf = self else { return }
            store.pullFeed(for: feedUrlString) { response, arg  in
                guard let episodes = response else { print("no"); return }
                resultsList.episodes = episodes
                DispatchQueue.main.async {
                    resultsList.collectionView.reloadData()
                    strongSelf.navigationController.pushViewController(resultsList, animated: false)
                    searchViewController.tableView.isUserInteractionEnabled = true
                }
            }
        }
    }
}

extension SearchTabCoordinator: PodcastListViewControllerDelegate {
    
    func didSelectPodcastAt(at index: Int, podcast: CasterSearchResult, with episodes: [Episodes]) {
        let concurrent = DispatchQueue(label: "concurrentBackground",
                                       qos: .background,
                                       attributes: .concurrent,
                                       autoreleaseFrequency: .inherit,
                                       target: nil)
        concurrent.async { [weak self] in
            guard let strongSelf = self else { return }
            var playerPodcast = podcast
            playerPodcast.episodes = episodes
            let playerViewController = PlayerViewController(index: index,
                                                            caster: playerPodcast,
                                                            image: nil)
            playerViewController.delegate = strongSelf
            DispatchQueue.main.async {
                strongSelf.navigationController.setNavigationBarHidden(true, animated: false)
                strongSelf.navigationController.pushViewController(playerViewController, animated: false)
            }
        }
    }
}

extension SearchTabCoordinator: PlayerViewControllerDelegate {
    func playPaused(tapped: Bool) {
        
    }
    
    func addItemToPlaylist(item: CasterSearchResult, index: Int) {
        guard let newItem = PodcastPlaylistItem.addItem(item: item, for: index) else { return }
        let controller = navigationController.viewControllers.last as! PlayerViewController
        navigationController.setNavigationBarHidden(false, animated: false)
        controller.tabBarController?.selectedIndex = 1
        guard let tab =  controller.tabBarController else { return }
        let nav = tab.viewControllers?[1] as! UINavigationController
        let playlists = nav.viewControllers[0] as! PlaylistsViewController
        playlists.reference = .addPodcast
        playlists.index = index
        playlists.item = item
        controller.playerView.alpha = 1
        controller.view.bringSubview(toFront: controller.playerView)
        controller.tabBarController?.tabBar.alpha = 1
        delegate?.podcastItem(toAdd: item, with: index)
    }
    
    func skipButton(tapped: String) {
        print(tapped)
    }
    
    func backButton(tapped: String) {
        print(tapped)
    }
    
    func pauseButton(tapped: String) {
        print(tapped)
    }
    
    func playButton(tapped: String) {
        print(tapped)
    }
    
    func navigateBack(tapped: Bool) {
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.viewControllers.last?.tabBarController?.tabBar.alpha = 1
    }
}
