import UIKit

class PodcastCell: UICollectionViewCell {
   
    static let reuseIdentifier = "Cell"
    
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
        playTimeLabel.textAlignment = .left
        playTimeLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        return playTimeLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    func configureCell(model: PocastCellModel) {
        layoutSubviews()
        setupConstraints()
        self.layoutIfNeeded()
        podcastImageView.image = model.podcastImage
        var intTime = Int(model.item.playtime)
        dump(intTime)
        var timeString = String.constructTimeString(time: intTime)
        print(timeString)
        playTimeLabel.text = String.constructTimeString(time: intTime)
        podcastTitleLabel.text = model.podcastTitle
    }
}

extension PodcastCell: Reusable {
    
    func setupConstraints() {
        contentView.addSubview(podcastTitleLabel)
        podcastTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        podcastTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        podcastTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        podcastTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.04).isActive = true
        
        contentView.addSubview(playTimeLabel)
        playTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        playTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        playTimeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        playTimeLabel.topAnchor.constraint(equalTo: podcastTitleLabel.topAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        //podcastTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}


