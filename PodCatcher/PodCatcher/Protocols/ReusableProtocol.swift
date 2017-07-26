import UIKit

protocol Reusable { }

extension Reusable where Self: UICollectionViewCell  {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
