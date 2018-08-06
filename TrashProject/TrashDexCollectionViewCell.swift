//
//  TrashDexCollectionViewCell.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/5/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

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
