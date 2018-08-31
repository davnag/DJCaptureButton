//
//  UIView+forceTouchCapabilityAvailable.swift
//  CaptureButton
//
//  Created by David Jonsén on 2018-08-31.
//  Copyright © 2018 David Jonsén. All rights reserved.
//

import UIKit

extension UIView {

    func forceTouchCapabilityAvailable() -> Bool {

        return traitCollection.forceTouchCapability == .available
    }
}
