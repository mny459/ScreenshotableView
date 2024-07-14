//
//  CoreScreenshotExtensions.swift
//  
//
//  Created by Rickey on 2024/6/21.
//

import SwiftUI

extension UIView {
    func takeScreenshot(afterScreenUpdates: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

extension View {
    func takeScreenshot(frame: CGRect, afterScreenUpdates: Bool) -> UIImage {
        let controller = UIHostingController(rootView: self.fixedSize(horizontal: false, vertical: true))
        guard let view = controller.view else { return .init() }

        let targetSize = controller.sizeThatFits(in: .init(width: view.intrinsicContentSize.width, height: .greatestFiniteMagnitude))
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let image = renderer.image { _ in
            view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
