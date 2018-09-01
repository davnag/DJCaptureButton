//
//  ViewController.swift
//  DJCaptureButton
//
//  Created by David Jonsén on 08/31/2018.
//  Copyright (c) 2018 David Jonsén. All rights reserved.
//

import DJCaptureButton
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previewLabel: UILabel!

    @IBOutlet weak var captureButton: DJCaptureButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension ViewController: DJCaptureButtonDelegate {

    func captureButtonDidFire(captureButton: DJCaptureButton) {

        previewLabel.text = "📸"

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.previewLabel.text = "📷"
        }
    }
}
