import UIKit

extension UIViewController {
  func addFillerChildViewController(_ childController: UIViewController, toView: UIView? = nil) {
    addChildViewController(childController)
    var parentView = childController.view
    if let toView = toView {
      parentView = toView
    }
    view.addFillerSubview(parentView!)
    childController.didMove(toParentViewController: self)
  }

  func alert(message: String, title: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }

  func lowMemoryAlert(message: String? = nil, title: String? = nil) {

    let message = "Your device has low memory. Reboot your device ASAP."
    let title = "Low Memory"

    self.alert(message: message, title: title)
  }

  func networkConnectionAlert(message: String?, title: String?) {

    let message = "No network connection or the bandwidth is very low. Ensure you have " +
        "good network connection."
    let title = "No Network Connection or Low Bandwidth"


    self.alert(message: message, title: title)
  }

  func notImplementedAlert() {

    let message = "This function has not implemented yet."
    let title = "Not Implemented"

    self.alert(message: message, title: title)
  }

}
