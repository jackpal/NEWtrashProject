//
//  InstructionsViewController.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/9/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()

    if let aboutPath = Bundle.main.path(forResource: "Instructions", ofType: "html") {
      if let aboutData = NSData(contentsOfFile: aboutPath) {
        do {
          try textView.attributedText = NSAttributedString(
            data: aboutData as Data,
            options:[.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        } catch {
          // Do nothing.
        }
      }
    }
  }


}
