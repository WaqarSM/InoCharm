import Foundation
import Twilio

func sendSMSUsingTwilio(to recipient: String, message: String) {
    // Set up your Twilio account credentials
    let accountSID = "ACdb6dbe1f26c50e6777281b4b76c1a65\\c" //remove the \\
    let authToken = "15bff5b989471aec8c47f94ebb2fc2d\\9"//remove the \\
    let fromNumber = "+1647885529"
    
    // Initialize a Twilio client with your credentials
    let client = TwilioClient(accountSid: accountSID, authToken: authToken)
    
    // Set the recipient and message body
    let toNumber = recipient
    let messageBody = message
    
    // Send the SMS message using the Twilio client
    client.messages.create(
        to: toNumber,
        from: fromNumber,
        body: messageBody
    ) { result, error in
        if let error = error {
            print("Error sending SMS using Twilio: \(error.localizedDescription)")
        } else {
            print("SMS sent using Twilio!")
        }
    }
}




