import UIKit

enum MenuActive {
    case none, active, hidden
}

class PodcastListViewController: UIViewController, UIScrollViewDelegate {
    
     let entryPop = EntryPopover()
    
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var topView = PodcastListTopView()
    var state: PodcasterControlState = .toCollection
    var menuPop = BottomMenuPopover()
    weak var delegate: PodcastListViewControllerDelegate?
    var caster: Caster!
    var menuActive: MenuActive = .none
    var leftButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupNavigationController()
        collectionView.register(PodcastCell.self)
        collectionView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        let topFrameHeight = view.bounds.height / 2
        let topFrameWidth = view.bounds.width
        topView.frame = CGRect(x: 0, y: 0, width: topFrameWidth, height: topFrameHeight / 1.5)
        topView.podcastImageView.image = caster.artwork
        title = caster.name
        topView.delegate = self
        topView.layoutSubviews()
        view.addSubview(topView)
        collectionView.frame = CGRect(x: topView.bounds.minX, y: topView.frame.maxY, width: topFrameWidth, height: view.bounds.height)
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.alpha = 1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        switch state {
        case .toCollection:
            navigationController?.popViewController(animated: animated)
        case .toPlayer:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y > 500 {
            UIView.animate(withDuration: 1) {
                print(offset.y)
                self.topView.removeFromSuperview()
                self.collectionView.frame = self.view.bounds
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                let topFrameHeight = self.view.bounds.height / 2
                let topFrameWidth = self.view.bounds.width
                self.topView.frame = CGRect(x: 0, y: 0, width: topFrameWidth, height: topFrameHeight / 1.5)
                self.topView.podcastImageView.image = self.caster.artwork
                self.topView.layoutSubviews()
                self.view.addSubview(self.topView)
                self.collectionView.frame = CGRect(x: self.topView.bounds.minX, y: self.topView.frame.maxY, width: topFrameWidth, height: self.view.bounds.height)
            }
        }
    }
}

extension PodcastListViewController: UICollectionViewDelegate {
    
    func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout.invalidateLayout()
        layout.sectionInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 50, height: 100)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    }
    
    // MARK: - Setup navbar UI
    
    func setupNavigationController() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)]
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
}

extension PodcastListViewController: UICollectionViewDataSource {
    
    // MARK: - CollectionViewController method implementations
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let caster = caster {
            return caster.assets.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PodcastCell
        if let caster = caster, let artwork = caster.artwork {
            let model = PocastCellModel(podcastImage: artwork, podcastTitle: caster.assets[indexPath.row].title, item: caster.assets[indexPath.row])
            cell.configureCell(model: model)
        }
        return cell
    }
}

extension PodcastListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:0, left: 0, bottom: 10, right: 0)
    }
    
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - Popvoer view implmented
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        state = .toPlayer
        delegate?.didSelectTrackAt(at: indexPath.row, with: caster)
    }
}

extension PodcastListViewController: TopViewDelegate {
    
    func entryPop(pop: Bool) {
        popEntry()
    }

    
    func popBottomMenu(pop: Bool) {
        // guard let model = model else { return }
        switch menuActive {
        case .none:
            showMenu()
            menuActive = .active
        case .active:
            dismissMenu()
            menuActive = .hidden
        case .hidden:
            showMenu()
            menuActive = .active
        }
    }
    
    func showMenu() {
        menuPop.popView.delegate = self
        menuPop.setupPop()
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.menuPop.showPopView(viewController: strongSelf)
            strongSelf.menuPop.popView.isHidden = false
        }
    }
    
    func dismissMenu() {
        menuPop.popView.removeFromSuperview()
        menuPop.hidePopView(viewController: self)
        view.sendSubview(toBack: menuPop)
    }
    
    func popEntry() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.entryPop.showPopView(viewController: strongSelf)
            strongSelf.entryPop.popView.isHidden = false
        }
        entryPop.popView.doneButton.addTarget(self, action: #selector(hidePop), for: .touchUpInside)
    }
    
    func hidePop() {
        entryPop.hidePopView(viewController: self)
        collectionView.reloadData()
    }
}

extension PodcastListViewController: MenuDelegate {
    
    func optionOneTapped() {
        print("download")
    }
    
    func optionTwoTapped() {
        print("Option two tapped")
    }
    
    func optionThreeTapped() {
        print("option three")
    }
}
