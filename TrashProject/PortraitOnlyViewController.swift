import UIKit

/// A base class view controller that supports portrait mode.
/// Simplifies our UI by not having to handle landscape mode.
class PortraitOnlyViewController : UIViewController {

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .portrait
    } else {
      return [.portrait, .portraitUpsideDown]
    }
  }

}
