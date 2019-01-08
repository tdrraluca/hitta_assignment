//
//  RatingView.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol RatingViewDelegate: class {
    func didSelect(rating: Int)
}

class RatingView: UIView {

    weak var delegate: RatingViewDelegate?

    private (set) var model: Model
    private let elementsStackView = UIStackView()
    private var ratingControls = [RatingItemControl]()

    init(frame: CGRect, model: Model) {
        self.model = model
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
        updateSelection()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("View not available from IB")
    }

    func update(rating: Int?) {
        model.currentRating = rating
        updateSelection()
    }

    private func setupSubviews() {
        elementsStackView.axis = .horizontal
        elementsStackView.distribution = .equalSpacing
        elementsStackView.alignment = .fill

        let ratingItemsModel = RatingItemControl.Model(selectedImage: model.selectedImage,
                                                       unselectedImage: model.unselectedImage)
        for index in 0..<model.maxRating {
            let ratingItemControl = RatingItemControl(frame: .zero,
                                                      model: ratingItemsModel)
            ratingItemControl.tag = index
            ratingItemControl.addTarget(self, action: #selector(ratingElementControlTapped), for: .touchUpInside)
            ratingControls.append(ratingItemControl)
            elementsStackView.addArrangedSubview(ratingItemControl)
        }
        addSubview(elementsStackView)
    }

    private func setupConstraints() {
        addFillingConstraints(for: elementsStackView)
    }

    private func updateSelection() {
        for (index, ratingItemControl) in ratingControls.enumerated() {
            if let currentRating = model.currentRating, index < currentRating {
                ratingItemControl.isSelected = true
            } else {
                ratingItemControl.isSelected = false
            }
        }
    }

    @objc func ratingElementControlTapped(_ sender: RatingItemControl) {
        let currentRating = sender.tag + 1
        model.currentRating = currentRating
        updateSelection()

        delegate?.didSelect(rating: currentRating)
    }
}

extension RatingView {
    struct Model {
        let maxRating: Int
        var currentRating: Int?
        let selectedImage: UIImage
        let unselectedImage: UIImage
    }
}

class RatingItemControl: UIControl {

    private let model: Model
    private let imageView = UIImageView()

    override var isSelected: Bool {
        didSet {
            imageView.image = isSelected ? model.selectedImage : model.unselectedImage
        }
    }

    init(frame: CGRect, model: Model) {
        self.model = model
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("View not available from IB")
    }

    private func setupSubviews() {
        imageView.image = model.unselectedImage
        imageView.contentMode = .center
        addSubview(imageView)
    }

    private func setupConstraints() {
        addFillingConstraints(for: imageView)
    }
}

extension RatingItemControl {
    struct Model {
        let selectedImage: UIImage
        let unselectedImage: UIImage
    }
}
