//
//  TrashDexViewController.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/5/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import UIKit

class TrashDexViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
        super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
          flowLayout.itemSize = CGSize(width: collectionView.bounds.width / 2 - 20, height: 120)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct TrashEntry {
  var imageResource: String
  var labelText: String
}

extension TrashDexViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allPieces.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrashCell", for: indexPath) as! TrashDexCollectionViewCell
    let piece = allPieces[indexPath.row]
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
