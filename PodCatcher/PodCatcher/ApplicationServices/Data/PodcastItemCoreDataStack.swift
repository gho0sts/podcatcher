import UIKit
import CoreData

struct PodcastItemCoreDataStack {
    
    var podcasts: [NSManagedObject] = []
    
    mutating func save(audioUrlString: String, name: String, playlist: String, image: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.coreData.managedContext
        guard let entity = NSEntityDescription.entity(forEntityName: "PodcastPlaylistItem", in: managedContext) else { return }
        let podcast = NSManagedObject(entity: entity, insertInto: managedContext)
        podcast.setValue(image, forKey: "artwork")
        podcast.setValue(audioUrlString, forKey: "audioUrl")
        podcast.setValue(playlist, forKey: "playlistId")
        podcast.setValue(name, forKey: "episodeTitle")
        do {
            try managedContext.save()
            podcasts.append(podcast)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    mutating func fetchFromCore() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.coreData.managedContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PodcastPlaylist")
        do {
            podcasts = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
