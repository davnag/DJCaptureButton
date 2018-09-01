//
//  CaptureButton.swift
//  CaptureButton
//
//  Created by David Jonsén on 2018-08-31.
//  Copyright © 2018 David Jonsén. All rights reserved.
//

import UIKit

@objc
public protocol DJCaptureButtonDelegate: class {

    func captureButtonDidFire(captureButton: DJCaptureButton)
}

@IBDesignable
open class DJCaptureButton: UIButton {

    // MARK: - IBInspectable

    @IBInspectable public var borderWidth: CGFloat = 4.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable public var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable public var middleCircleOffset: CGFloat = 4.0 {
        didSet {
            updateMiddleCircle()
        }
    }

    @IBInspectable public var middleCircleColor: UIColor = .white {
        didSet {
            middleCircle.fillColor = middleCircleColor.cgColor
        }
    }

    // MARK: - Public

    @IBOutlet public weak var delegate: DJCaptureButtonDelegate?

    public var generateFeedback: Bool = true

    // MARK: - Internal

    internal lazy var impactFeedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    internal var forceTouchGestureRecognizer: ForceTouchGestureRecognizer?

    internal lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gesture.delegate = self
        return gesture
    }()

    internal lazy var middleCircle: CAShapeLayer = {
        let circle = CAShapeLayer()
        return circle
    }()

    // MARK: -

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupButton()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupButton()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let radius = bounds.size.width / 2.0
        layer.cornerRadius = radius

        updateMiddleCircle()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard forceTouchGestureRecognizer == nil else {

            forceTouchGestureRecognizer?.isEnabled = forceTouchCapabilityAvailable()
            return
        }

        if forceTouchCapabilityAvailable() {
            setupForceTouchGestureRecognizer()
        }
    }
}

// MARK: - Setup

extension DJCaptureButton {

    internal func setupButton() {

        setupBorder()
        setupMiddleCircle()
        setupTapGestureRecognizer()
    }

    internal func setupBorder() {

        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

    internal func setupMiddleCircle() {

        middleCircle.fillColor = middleCircleColor.cgColor
        middleCircle.frame = bounds

        layer.addSublayer(middleCircle)
    }

    internal func setupTapGestureRecognizer() {

        addGestureRecognizer(tapGestureRecognizer)
    }

    internal func setupForceTouchGestureRecognizer() {

        let forceGesture = ForceTouchGestureRecognizer(target: self, action: #selector(handleForce))
        forceGesture.delegate = self
        addGestureRecognizer(forceGesture)

        forceTouchGestureRecognizer = forceGesture
    }
}

// MARK: -

extension DJCaptureButton {

    @objc
    internal func handleTap(gesture: UITapGestureRecognizer) {

        animateTapGesture()

        captureButtonFireAction()
    }

    @objc
    internal func handleForce(gesture: ForceTouchGestureRecognizer) {

        switch gesture.state {

        case .ended, .cancelled:

            if tapGestureRecognizer.isEnabled == false {
                captureButtonFireAction()
            }

            gesture.isEnabled = true

            resetMiddleCircle(delay: 100)

            tapGestureRecognizer.isEnabled = true

        case .changed:

            if  tapGestureRecognizer.isEnabled {
                tapGestureRecognizer.isEnabled = false
            }

            let scale = 1 - min(gesture.force, 0.2)

            middleCircle.transform = CATransform3DMakeScale(scale, scale, 1.0)

            guard scale <= 0.8 else {
                return
            }

            gesture.isEnabled = false

//            fireButton()

        default:
            break
        }
    }
}

extension DJCaptureButton {

    internal func updateMiddleCircle() {

        let offset = borderWidth + middleCircleOffset

        middleCircle.path = UIBezierPath(ovalIn: CGRect(x: offset, y: offset, width: bounds.width - (offset * 2), height: bounds.height - (offset * 2))).cgPath
    }

    internal func resetMiddleCircle(delay milliseconds: Int = 0) {

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
            self.middleCircle.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }
    }

    internal func captureButtonFireAction() {

        if generateFeedback {
            impactFeedbackGenerator.impactOccurred()
        }

        delegate?.captureButtonDidFire(captureButton: self)
    }
}

extension DJCaptureButton {

    public func animateTapGesture() {

        middleCircle.transform = CATransform3DMakeScale(0.9, 0.9, 1.0)

        resetMiddleCircle(delay: 100)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension DJCaptureButton: UIGestureRecognizerDelegate {

     public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        return true
    }
}
