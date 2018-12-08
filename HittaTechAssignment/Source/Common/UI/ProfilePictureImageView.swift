//
//  ProfilePictureImageView.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 07/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

class ProfilePictureImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }

    private func setupConstraints() {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
    }
}
