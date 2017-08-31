//: Playground - noun: a place where people can play

import UIKit

func isValidEmail(_ string:String) -> Bool {
    let emailRegularExpressionFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let email = NSPredicate(format:"SELF MATCHES %@", emailRegularExpressionFormat)
    return email.evaluate(with: string)
}



