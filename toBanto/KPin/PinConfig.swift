//
//  PinConfig.swift
//  toBanto
//
//  Created by mora hakim on 07/11/21.
//

import Foundation
import UIKit

public struct PinConfig {
    public var otpLength: OTPLength?
    public var dotColor: UIColor?
    public var lineColor: UIColor?
    public var viewMain: UIView?
    public var spacing: CGFloat?
    public var isSecureTextEntry: Bool?
    public var placeHolderText: String?
    public var showPlaceHolder: Bool?
    init(numberOfFields:OTPLength = .four, dotColor:UIColor = UIColor.black, lineColor:UIColor = .clear, viewMain:UIView = UIView(), spacing:CGFloat = 8.0, secureTextEntry: Bool = true, placeHolderText: String = "*", showPlaceHolder: Bool = true) {
        self.otpLength     = numberOfFields
        self.dotColor           = dotColor
        self.lineColor          = lineColor
        self.viewMain           = viewMain
        self.spacing            = spacing
        self.isSecureTextEntry    = secureTextEntry
        self.placeHolderText    = placeHolderText
        self.showPlaceHolder    = showPlaceHolder
    }
}
