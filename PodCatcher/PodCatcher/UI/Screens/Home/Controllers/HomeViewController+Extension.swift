import UIKit

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topCollectionView.dequeueReusableCell(forIndexPath: indexPath) as TopPodcastCell
        if let imagurl = topItems[indexPath.row].podcastArtUrlString, let url = URL(string: imagurl) {
            cell.albumArtView.downloadImage(url: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.items.count
    }
    
    func setupBottom() {
        topCollectionView.delegate = self
        topCollectionView.isPagingEnabled = true
        topCollectionView.isScrollEnabled = true
        topCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func setup(view: UIView, newLayout: HomeItemsFlowLayout) {
        newLayout.setup()
        setupHome(with: newLayout)
        collectionView.frame = CGRect(x: 0, y: view.bounds.midY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupHome(with newLayout: HomeItemsFlowLayout) {
        collectionView.collectionViewLayout = newLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataSource.dataType {
        case .local:
            delegate?.didSelect(at: indexPath.row)
        case .network:
            delegate?.didSelect(at: indexPath.row, with: dataSource.items[indexPath.row])
        }
    }
    
    func logoutTapped() {
        delegate?.logout(tapped: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func collectionViewConfiguration() {
        setup(view: view, newLayout: HomeItemsFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.backgroundColor = .clear
    }
}
