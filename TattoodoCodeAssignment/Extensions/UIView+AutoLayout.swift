//
//  UIView+AutoLayout.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindTo(_ view: UIView, margin: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        bindTo(view, insets: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
    }
    
    func bindTo(_ view: UIView, insets: UIEdgeInsets) {
        let leading: NSLayoutXAxisAnchor = view.leadingAnchor
        let trailing: NSLayoutXAxisAnchor = view.trailingAnchor
        let top: NSLayoutYAxisAnchor = view.topAnchor
        let bottom: NSLayoutYAxisAnchor = view.bottomAnchor
        leadingAnchor.constraint(equalTo: leading, constant: insets.left).activate()
        trailingAnchor.constraint(equalTo: trailing, constant: -insets.right).activate()
        topAnchor.constraint(equalTo: top, constant: insets.top).activate()
        bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom).activate()
    }
    
    func bindLeadingTrailing(_ view: UIView, margin: CGFloat) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).activate()
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).activate()
    }

    func bindTo(size: CGSize) {
        widthAnchor.constraint(equalToConstant: size.width).activate()
        heightAnchor.constraint(equalToConstant: size.height).activate()
    }
}

extension NSLayoutConstraint {
    func activate() {
        isActive = true
    }
}
