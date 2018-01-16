import UIKit

final class TabBarController: UITabBarController {
    
    var dataSource: BaseMediaControllerDataSource!
    
    var first: Bool  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTabBar()
        
    }
    
    // General dimensions and look of tabbar
    
    private func setupTabBar() {
        tabBar.autoresizesSubviews = false
        tabBar.clipsToBounds = true
    }
    
    func setup(with controllers: [UINavigationController]) {
        setTabTitles(controllers: controllers)
    }
    
 //   #imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate)
  //  #imageLiteral(resourceName: "home").withRenderingMode(.a
    func setTabTitles(controllers: [UINavigationController]) {
        let home = #imageLiteral(resourceName: "house-gray").withRenderingMode(.alwaysTemplate)
        let normalImage = #imageLiteral(resourceName: "lightGrayPodcasts").withRenderingMode(.alwaysTemplate)
        let normalImageTwo = #imageLiteral(resourceName: "heart-gray").withRenderingMode(.alwaysTemplate)
        let normalImageThree = #imageLiteral(resourceName: "search-gray").withRenderingMode(.alwaysTemplate)
        let normalImageFour = #imageLiteral(resourceName: "settings-dark-gray").withRenderingMode(.alwaysTemplate)
        
        viewControllers = controllers
        
        tabBar.items?[0].image = home
        tabBar.items?[1].image = normalImageTwo
        tabBar.items?[2].image = normalImage
        tabBar.items?[3].image = normalImageThree
        tabBar.items?[4].image = normalImageFour
        
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Podcasts"
        tabBar.items?[2].title = "Browse"
        tabBar.items?[3].title = "Search"
        tabBar.items?[4].title = "Setting"
        
        selectedIndex = 0
        first = true
        
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                    item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysTemplate)
                        //UIImage(named: "(Imagename)-a")?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }
    
    private func setupTab(settingsViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: settingsViewController)
    }
}
