import UIKit

class EmptyCastsView: UIView {
    
    private var infoLabel: UILabel = UILabel.setupInfoLabel(infoText: "No podcasts...yet.")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.textColor = PlayerViewConstants.titleViewBackgroundColor
        backgroundColor = .white
        setup(infoLabel: infoLabel)
    }
    
    func configure() {
        layoutSubviews()
    }
    
    private func setup(infoLabel: UILabel) {
        addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * -0.05).isActive = true
    }
}
