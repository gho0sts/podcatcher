import UIKit

final class EmptyView: UIView {
    
    private var infoLabel: UILabel = {
        var label = UILabel.setupInfoLabel(infoText: "No Podcasts Have Been Added")
        label.textColor = .mainColor
        return label
    }()
    
    private var musicIcon: UIImageView = {
        var musicIcon = UIImageView()
        musicIcon.image = #imageLiteral(resourceName: "headphones-blue").withRenderingMode(.alwaysTemplate)
        musicIcon.tintColor = .mainColor
        return musicIcon
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CALayer.createGradientLayer(with: [UIColor.white.cgColor, UIColor.lightGray.cgColor],
                                    layer: layer,
                                    bounds: bounds)
        setup(musicIcon: musicIcon)
        setup(infoLabel: infoLabel)
    }
    
    func configure() {
        layoutSubviews()
    }
    
    private func setup(musicIcon: UIView) {
        addSubview(musicIcon)
        musicIcon.translatesAutoresizingMaskIntoConstraints = false
        musicIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: EmptyViewConstants.musicIconHeightMultiplier).isActive = true
        musicIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: EmptyViewConstants.musicIconWidthMutliplier).isActive = true
        musicIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        musicIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: EmptyViewConstants.musicIconCenterYOffset).isActive = true
    }
    
    private func setup(infoLabel: UILabel) {
        addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: EmptyViewConstants.musicIconWidthMutliplier).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
