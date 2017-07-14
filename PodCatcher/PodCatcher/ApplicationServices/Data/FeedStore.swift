import UIKit
import CoreData

class FeedCoreDataStack {
    
    var feeds: [NSManagedObject] = []
    
    func save(feedUrl: String, podcastTitle: String, episodeCount: Int, lastUpdate: NSDate, image: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.coreData.managedContext
        let entity = NSEntityDescription.entity(forEntityName: "Subscription", in: managedContext)!
        let subscription = NSManagedObject(entity: entity, insertInto: managedContext)
        let podcastArtImageData = UIImageJPEGRepresentation(image, 1) as! NSData
        subscription.setValue(feedUrl, forKeyPath: "feedUrl")
        subscription.setValue(podcastTitle, forKeyPath: "podcastTitle")
        subscription.setValue(podcastArtImageData, forKey: "artworkImage")
        subscription.setValue(episodeCount, forKey: "episodeCount")
        subscription.setValue(lastUpdate, forKey: "lastUpdate")
        do {
            try managedContext.save()
            feeds.append(subscription)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchFromCore() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.coreData.managedContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Subscription")
        do {
            feeds = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}