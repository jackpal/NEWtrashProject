//
//  AboutViewController.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/6/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import UIKit


class AboutViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  override func viewDidLoad() {
        super.viewDidLoad()

        if let aboutPath = Bundle.main.path(forResource: "About", ofType: "html") {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
