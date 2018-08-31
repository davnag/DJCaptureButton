//
//  ForceTouchGestureRecognizer.swift
//  CaptureButton
//
//  Created by David Jonsén on 2018-08-31.
//  Copyright © 2018 David Jonsén. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

final class ForceTouchGestureRecognizer: UIGestureRecognizer {

    private(set) var force: CGFloat = 0.0

    convenience init() {
        self.init(target: nil, action: nil)

        setupGesture()
    }

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)

        setupGesture()
    }

    private func setupGesture() {

        cancelsTouchesInView = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        updateForce(.began, touches: touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        updateForce(.changed, touches: touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)

        updateForce(.ended, touches: touches)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)

        updateForce(.cancelled, touches: touches)
    }

    private func updateForce(_ state: UIGestureRecognizerState, touches: Set<UITouch>) {

        guard let firstTouch = touches.first else {
            return
        }

        force = firstTouch.force / firstTouch.maximumPossibleForce

        self.state = state
    }

    public override func reset() {
        super.reset()

        force = 0.0
    }
}
