//
//  UIView+Layout.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 07/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

extension UIView {
    func addFillingConstraints(for subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
