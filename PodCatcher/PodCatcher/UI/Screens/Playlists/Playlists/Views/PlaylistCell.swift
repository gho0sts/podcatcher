import UIKit

final class PlaylistCell: UITableViewCell, Reusable {
    
    static let reuseIdentifier = "PlaylistCell"
    
    var mode: PlaylistCellMode = .select {
        didSet {
            switch mode {
            case .select:
                deleteImageView.alpha = 1
                let image = #imageLiteral(resourceName: "next").withRenderingMode(.alwaysTemplate)
                deleteImageView.image = image
                deleteImageView.tintColor = .darkGray
            case .delete:
                deleteImageView.alpha = 0.6
                let image = #imageLiteral(resourceName: "circle-x").withRenderingMode(.alwaysTemplate)
                deleteImageView.image = image
                deleteImageView.tintColor = .red
            }
        }
    }
    
    var albumArtView: UIImageView = {
        var album = UIImageView()
        return album
    }()
    
    var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .clear
        return separatorView
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    var deleteImageView: UIImageView = {
        let delete = UIImageView()
        return delete
    }()
    
    var numberOfItemsLabel: UILabel = {
        let numberOfItems = UILabel()
        numberOfItems.textColor = .black
        numberOfItems.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        numberOfItems.textAlignment = .center
        numberOfItems.numberOfLines = 0
        return numberOfItems
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.layer.borderWidth = 1
        setup(titleLabel: titleLabel)
        setup(numberOfItemsLabel: numberOfItemsLabel)
        setup(albumArtView: albumArtView)
        setup(deleteImageView: deleteImageView)
        selectionStyle = .none
        albumArtView.layer.setCellShadow(contentView: self)
        setupSeparator()
    }
    
    private func setShadow() {
        layer.setCellShadow(contentView: contentView)
        let path =  UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius)
        layer.shadowPath = path.cgPath
    }
    
    func configure(image: UIImage, title: String, subtitle: String?, mode: PlaylistCellMode) {
        setShadow()
        self.mode = mode
        self.albumArtView.image = image
        self.titleLabel.text = title.uppercased()
        if let subtitle = subtitle {
            self.numberOfItemsLabel.text = subtitle
        } else {
            self.numberOfItemsLabel.text = "Podcasts"
        }
    }
    
    func setupShadow() {
        let shadowOffset = CGSize(width:-0.45, height: 0.2)
        let shadowRadius: CGFloat = 1.0
        let shadowOpacity: Float = 0.4
        contentView.layer.shadowRadius = shadowRadius
        contentView.layer.shadowOffset = shadowOffset
        contentView.layer.shadowOpacity = shadowOpacity
    }
    
    func setup(titleLabel: UILabel) {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.13).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: contentView.bounds.height * -0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func setup(numberOfItemsLabel: UILabel) {
        contentView.addSubview(numberOfItemsLabel)
        numberOfItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfItemsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.13).isActive = true
        numberOfItemsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: contentView.bounds.height * 0.008).isActive = true
        numberOfItemsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25).isActive = true
        numberOfItemsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setup(albumArtView: UIImageView) {
        contentView.addSubview(albumArtView)
        albumArtView.translatesAutoresizingMaskIntoConstraints = false
        albumArtView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width * 0.02).isActive = true
        albumArtView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        albumArtView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        albumArtView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setup(deleteImageView: UIImageView) {
        contentView.addSubview(deleteImageView)
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        deleteImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: contentView.bounds.width * -0.04).isActive = true
        deleteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        deleteImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.26).isActive = true
        deleteImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08).isActive = true
    }
    
    func setupSeparator() {
        setup(separatorView: separatorView)
        DispatchQueue.main.async {
            self.albumArtView.layer.cornerRadius = 4
            self.albumArtView.layer.borderWidth = 1
            let containerLayer = CALayer()
            containerLayer.shadowColor = UIColor.darkText.cgColor
            containerLayer.shadowRadius = 2
            containerLayer.shadowOffset = CGSize(width: 1, height: 1)
            containerLayer.shadowOpacity = 0.6
            self.albumArtView.layer.masksToBounds = true
            containerLayer.addSublayer(self.albumArtView.layer)
            self.layer.addSublayer(containerLayer)
        }
    }
    
    func setup(separatorView: UIView) {
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
        separatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
