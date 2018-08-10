//
//  TrashDexHeaderViewCollectionReusableView.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/8/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import UIKit

class TrashDexHeaderReusableView: UICollectionReusableView {
  @IBOutlet weak var label: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()

    self.label.text = nil
  }

}
