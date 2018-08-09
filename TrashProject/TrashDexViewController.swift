import UIKit

class TrashDexViewController: PortraitOnlyViewController {

  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.itemSize = CGSize(width: collectionView.bounds.width / 2 - 20, height: 120)
    }
  }
}

extension TrashDexViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return pieceIndex.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pieceIndex[section].count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrashCell", for: indexPath) as! TrashDexCollectionViewCell
    let piece = pieceIndex[indexPath.section][indexPath.row]
    cell.imageView.image = UIImage(named:piece.name)
    cell.textLabel.text = piece.description
    return cell
  }
}

extension TrashDexViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item + 1)
  }
}
