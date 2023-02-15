import Foundation
import UIKit
import TwillioCall // import the Twilio functions from TwillioCall.swift

let recipient = "+1234567890" // recipient's phone number
let message = "Hello, this is a message sent using Twilio!" // message body

sendSMSUsingTwilio(to: recipient, message: message)



