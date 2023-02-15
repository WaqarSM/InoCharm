import Foundation
import UIKit
import Builtin // import the iPhone built-in functions from builtin.swift

let recipient = "+1234567890" // recipient's phone number
let message = "Hello, this is a message sent using Twilio!" // message body

sendSMSUsingTwilio(to: recipient, message: message)



