import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    func sendSMSUsingiPhone(to recipient: String, message: String) {
        // Check if the device can send text messages
        if MFMessageComposeViewController.canSendText() {
            let messageController = MFMessageComposeViewController()
            messageController.recipients = [recipient]
            messageController.body = message
            messageController.messageComposeDelegate = self
            present(messageController, animated: true, completion: nil)
        } else {
            print("Device cannot send text messages")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Message composition cancelled")
        case .sent:
            print("Message sent!")
        case .failed:
            print("Message send failed")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
