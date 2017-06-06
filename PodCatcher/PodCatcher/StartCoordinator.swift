//
//  StartCoordinator.swift
//  PodCatcher
//
//  Created by Christopher Webb-Orenstein on 6/5/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class StartCoordinator: NavigationCoordinator {
    
    weak var delegate: CoordinatorDelegate?
    var window: UIWindow!
    var dataSource: BaseMediaControllerDataSource!
    let player = PCMediaPlayer()
    var childViewControllers: [UIViewController] = []
    
    var navigationController: UINavigationController {
        didSet {
            childViewControllers = navigationController.viewControllers
        }
    }
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    convenience init(navigationController: UINavigationController, window: UIWindow) {
        self.init(navigationController: navigationController)
        self.window = window
        
        player.getPlaylists { casts, lists in
            let listSet = Set(lists!)
            DispatchQueue.main.async {
                self.dataSource = BaseMediaControllerDataSource(casters: Array(listSet))
            }
        }
    }
    
    func start() {
        guard let window = window else { fatalError("Window object not created") }
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        addChild(viewController: splashViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func addChild(viewController: UIViewController) {
        childViewControllers.append(viewController)
        navigationController.viewControllers = childViewControllers
    }
}

extension StartCoordinator: SplashViewControllerDelegate {
    
    func splashViewFinishedAnimation(finished: Bool) {
        let startViewController = StartViewController()
        startViewController.delegate = self
        addChild(viewController: startViewController)
    }
}

extension StartCoordinator: StartViewControllerDelegate {
    
    func loginSelected() {
        delegate?.transitionCoordinator(type: .tabbar, dataSource: dataSource)
    }
    
    func createAccountSelected() {
        delegate?.transitionCoordinator(type: .tabbar, dataSource: dataSource)
    }
    
    func continueAsGuestSelected() {
        delegate?.transitionCoordinator(type: .tabbar, dataSource: dataSource)
    }
}
