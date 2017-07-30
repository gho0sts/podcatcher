import UIKit
import CoreData
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinator!
    var backgroundSessionCompletionHandler: (() -> Void)?
    var coreData: CoreDataStack!
    let reachability = Reachability()!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationStyling.setupUI()
        
        coreData = CoreDataStack(modelName: "PodCatcher")
        
        #if CLEAR_CACHES
            let cachesFolderItems = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
            for item in cachesFolderItems {
                try? FileManager.default.removeItem(atPath: item)
            }
        #endif
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            if UserDefaults.loadDefaultOnFirstLaunch() {
                print("not first launch")
                let startCoordinator = StartCoordinator(navigationController: UINavigationController(), window: window)
                mainCoordinator = MainCoordinator(window: window, coordinator: startCoordinator)
                mainCoordinator.start()
                mainCoordinator.setupTabCoordinator(dataSource: BaseMediaControllerDataSource())
            } else {
                print("first launch")
                let startCoordinator = StartCoordinator(navigationController: UINavigationController(), window: window)
                mainCoordinator = MainCoordinator(window: window, coordinator: startCoordinator)
                mainCoordinator.start()
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("background")
        backgroundSessionCompletionHandler = completionHandler
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreData.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PodCatcher")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

public extension UIViewController {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let closeButton = UIAlertAction(title: "Close", style: .default, handler: nil)
            alert.addAction(closeButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

