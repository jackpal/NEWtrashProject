import UIKit

class TrashDexCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()

    self.textLabel.text = nil
    self.imageView.image = nil
  }
}
