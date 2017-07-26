import UIKit
import CoreData

protocol ReloadableCollection: class {
    var playlistId: String { get set }
    var fetchedResultsController:NSFetchedResultsController<PodcastPlaylistItem>! { get set }
    var collectionView: UICollectionView { get set }
    func reloadData()
}

extension ReloadableCollection {
    
    func reloadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest:NSFetchRequest<PodcastPlaylistItem> = PodcastPlaylistItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "playlistId", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "playlistId == %@", playlistId)
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
            collectionView.reloadData()
        } catch let error {
            print(error)
        }
    }
}

protocol ReloadableTable: class {
    var fetchedResultsController:NSFetchedResultsController<PodcastPlaylist>! { get set }
    var tableView: UITableView { get set }
    var userID: String { get set }
    func reloadData()
}

extension ReloadableTable {
    func reloadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest:NSFetchRequest<PodcastPlaylist> = PodcastPlaylist.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "playlistId", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "uid == %@", userID)
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
}
