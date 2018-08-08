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
  
}
