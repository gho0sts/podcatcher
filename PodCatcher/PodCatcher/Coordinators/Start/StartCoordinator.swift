import UIKit

final class StartCoordinator: NavigationCoordinator {
    
    var type: CoordinatorType = .app
    weak var delegate: CoordinatorDelegate?
    var window: UIWindow!
    
    var childViewControllers: [UIViewController] = []
    
    var navigationController: UINavigationController {
        didSet {
            childViewControllers = navigationController.viewControllers
        }
    }
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        navigationController.edgesForExtendedLayout = []
    }
    
    convenience init(navigationController: UINavigationController, window: UIWindow) {
        self.init(navigationController: navigationController)
        self.window = window
    }
    
    func start() {
        guard let window = window else { fatalError("Window object not created") }
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        addChild(viewController: splashViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func skipSplash() {
        guard let window = window else { fatalError("Window object not created") }
        let startViewController = StartViewController()
        startViewController.delegate = self
        addChild(viewController: startViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func addChild(viewController: UIViewController) {
        childViewControllers.append(viewController)
        navigationController.viewControllers = childViewControllers
    }
    
    func removeChild(viewController: UIViewController) {
        childViewControllers = childViewControllers.filter { $0 !== viewController }
    }
}

extension StartCoordinator: SplashViewControllerDelegate {
    
    func splashAnimation(finished: Bool) {
        let startViewController = StartViewController()
        startViewController.delegate = self
        addChild(viewController: startViewController)
    }
}

extension StartCoordinator: StartViewControllerDelegate {
    
    func continueAsGuestSelected() {
        delegate?.transitionCoordinator(type: .tabbar)
    }
}
