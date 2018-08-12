import UIKit

class TrashDexCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!

  override func prepareForReuse() {
    super.prepareForReuse()

    self.textView.text = nil
    self.imageView.image = nil
  }
}
