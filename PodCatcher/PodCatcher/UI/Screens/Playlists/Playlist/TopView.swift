import UIKit

protocol TopViewDelegate: class {
    func popBottomMenu(popped: Bool)
    func entryPop(popped: Bool)
}

final class TopView: UIView {
    
    weak var delegate: TopViewDelegate?
    
    // MARK: - UI Properties
    
    var podcastImageView: UIImageView! = {
        var podcastImageView = UIImageView()
        podcastImageView.layer.setCellShadow(contentView: podcastImageView)
        return podcastImageView
    }()
    
    var podcastTitleLabel: UILabel! = {
        var podcastTitle = UILabel()
        podcastTitle.textAlignment = .center
        return podcastTitle
    }()
    
    var preferencesView: PreferencesView = {
        var preferencesView = PreferencesView()
        preferencesView.layoutSubviews()
        return preferencesView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        backgroundColor = .white
        layer.setCellShadow(contentView: self)
    }
    
    func setupConstraints() {
        setup(podcastImageView: podcastImageView)
        setup(titleLabel: podcastTitleLabel)
        setup(preferencesView: preferencesView)
        preferencesView.layoutSubviews()
    }
    
    func setup(podcastImageView: UIImageView) {
        addSubview(podcastImageView)
        podcastImageView.translatesAutoresizingMaskIntoConstraints = false
        podcastImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: PodcastListTopViewConstants.podcastImageViewCenterYOffset).isActive = true
        podcastImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        podcastImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PodcastListTopViewConstants.podcastImageViewHeightMultiplier).isActive = true
        podcastImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: PodcastListTopViewConstants.podcastImageViewWidthMultiplier).isActive = true
    }
    
    func setup(titleLabel: UILabel) {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: podcastImageView.bottomAnchor, constant: PodcastListTopViewConstants.titleLabelTopOffset).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PodcastListTopViewConstants.titleLabelHeightMultiplier).isActive = true
    }
    
    func setup(preferencesView: UIView) {
        addSubview(preferencesView)
        preferencesView.translatesAutoresizingMaskIntoConstraints = false
        preferencesView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        preferencesView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        preferencesView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PodcastListTopViewConstants.preferencesViewHeightMultiplier).isActive = true
    }
    
    func setup(miniPlayer: UIView) {
        addSubview(miniPlayer)
        miniPlayer.translatesAutoresizingMaskIntoConstraints = false
        miniPlayer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        miniPlayer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        miniPlayer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PodcastListTopViewConstants.preferencesViewHeightMultiplier).isActive = true
    }
}
