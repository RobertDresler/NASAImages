//
//  SkeletonLoadingView.swift
//  NASAImages
//
//  Created by Robert Dresler on 08/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesUI
import UIKit

protocol DummyContentDisplaying {

    func showDummyContent()
    func removeDummyContent()
}

enum SkeletonLoadingViewDisplayMode {

    /// Shown as-is through skeleton overlay
    case original

    /// Shown as outline in skeleton overlay
    case skeleton

    /// Shown as animating outline in skeleton overlay
    case animatingSkeleton
}

protocol SkeletonLoadingDisplayable {

    var skeletonEnabledViews: [SkeletonLoadingViewDisplayMode: [UIView]] { get }
}

final class SkeletonLoadingView: UIView {

    weak var baseView: UIView? {
        didSet {
            setNeedsLayout()
        }
    }

    var gradientColors: (UIColor, UIColor) = (.black, .black) {
        didSet {
            updateGradientColors()
        }
    }

    private let backgroundMaskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor.clear.cgColor
        return maskLayer
    }()

    private let animatingGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.25, 0.75, 1]
        return gradientLayer
    }()

    private let skeletonBackgroundLayer = CALayer()
    private let skeletonMaskLayer = CAShapeLayer()

    private let animatingGradientMaskLayer = CAShapeLayer()

    private let gradientAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-2, -1, 0, 1]
        animation.toValue = [0, 1, 2, 3]
        animation.duration = 1
        animation.repeatCount = .infinity
        return animation
    }()

    override public var backgroundColor: UIColor? {
        get {
            return backgroundMaskLayer.backgroundColor.flatMap(UIColor.init(cgColor:))
        } set {
            backgroundMaskLayer.fillColor = newValue?.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.addSublayer(backgroundMaskLayer)
        layer.addSublayer(skeletonBackgroundLayer)
        layer.addSublayer(animatingGradientLayer)

        updateGradientColors()

        registerNotifications()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        updateBackgroundMask()
        updateGradientMask()
        updateGradientMaskAndAnimation()
    }

    private func updateGradientColors() {
        let cgColors = [gradientColors.0, gradientColors.1].map { $0.cgColor }
        animatingGradientLayer.colors = cgColors + cgColors
    }

    private func updateBackgroundMask() {

        guard let baseView = baseView else { return }

        backgroundMaskLayer.frame = bounds
        let originalFrames = relevantViews(forMode: .original, startingAt: baseView).map(convertedFrame)

        backgroundMaskLayer.path = maskingPathWithHolesAt(originalFrames).cgPath
    }

    private func updateGradientMask() {

        guard let baseView = baseView else { return }

        skeletonBackgroundLayer.frame = bounds

        let skeletonFrames = relevantViews(forMode: .skeleton, startingAt: baseView).map(convertedFrame)

        skeletonMaskLayer.path = maskingPathShowingOnly(skeletonFrames).cgPath

        skeletonBackgroundLayer.mask = skeletonMaskLayer
    }

    private func updateGradientMaskAndAnimation() {

        guard let baseView = baseView else { return }

        animatingGradientLayer.frame = bounds

        let skeletonFrames = relevantViews(forMode: .animatingSkeleton, startingAt: baseView).map(convertedFrame)

        animatingGradientLayer.add(gradientAnimation, forKey: "gradientAnimation")

        animatingGradientMaskLayer.path = maskingPathShowingOnly(skeletonFrames).cgPath
        animatingGradientLayer.mask = animatingGradientMaskLayer
    }

    private func relevantViews(forMode mode: SkeletonLoadingViewDisplayMode, startingAt view: UIView) -> [UIView] {

        var foundViews: [UIView] = []

        if let view = view as? UIView & SkeletonLoadingDisplayable {
            foundViews += view.skeletonEnabledViews[mode, default: []]
        }

        for view in view.subviews where view.isHidden == false {
            foundViews += relevantViews(forMode: mode, startingAt: view)
        }

        return foundViews
    }

    private func maskingPathWithHolesAt(_ frames: [CGRect]) -> UIBezierPath {

        let path = UIBezierPath(rect: bounds)
        let framePaths = frames.map(UIBezierPath.init(rect:))

        framePaths.forEach(path.append)

        return path
    }

    private func maskingPathShowingOnly(_ frames: [CGRect]) -> UIBezierPath {

        let path = UIBezierPath()
        let framePaths = frames.map { frame in UIBezierPath(roundedRect: frame, cornerRadius: 4) }

        framePaths.forEach(path.append)

        return path
    }

    private func convertedFrame(for view: UIView) -> CGRect {
        return convert(view.frame, from: view.superview)
    }

    private func registerNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc private func willEnterForeground() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
