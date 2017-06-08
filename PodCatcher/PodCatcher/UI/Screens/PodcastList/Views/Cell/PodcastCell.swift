import UIKit

class PodcastCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    var podcastImageView: UIImageView = {
        var teamMemberImage = UIImageView()
        teamMemberImage.layer.borderWidth = 2
        teamMemberImage.clipsToBounds = true
        return teamMemberImage
    }()
    
    var podcastTitleLabel: UILabel = {
        var podcastTitleLabel = UILabel()
        podcastTitleLabel.sizeToFit()
        podcastTitleLabel.textAlignment = .left
        podcastTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        return podcastTitleLabel
    }()
    
    var playTimeLabel: UILabel = {
        var playTimeLabel = UILabel()
        playTimeLabel.sizeToFit()
        playTimeLabel.textAlignment = .right
        playTimeLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        return playTimeLabel
    }()
    
    // MARK: - Configuration Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 2.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.podcastCell(viewRadius: contentView.layer.cornerRadius)
    }
    
    func configureCell(model: PocastCellModel) {
        layoutSubviews()
        setupConstraints()
        layoutIfNeeded()
        podcastImageView.image = model.podcastImage
        let intTime = Int(model.item.playtime)
        let timeString = String.constructTimeString(time: intTime)
        playTimeLabel.text = String.constructTimeString(time: intTime)
        podcastTitleLabel.text = model.podcastTitle
    }
    
    func setupConstraints() {
        contentView.addSubview(podcastTitleLabel)
        podcastTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        podcastTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: PodcastCellConstants.podcastTitleLabelWidthMultiplier).isActive = true
        podcastTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: PodcastCellConstants.podcastTitleLabelLeftOffset).isActive = true
        podcastTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(playTimeLabel)
        playTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        playTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: PodcastCellConstants.playtimeLabelWidthMultiplier).isActive = true
        playTimeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: PodcastCellConstants.playtimeLabelRightOffset).isActive = true
        playTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

