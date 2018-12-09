//
//  OwnReviewView.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 09/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol OwnReviewViewDelegate: class {
    func didSelectReviewEditing()
}

class OwnReviewView: UIView, ReviewViewDelegate {

    weak var delegate: OwnReviewViewDelegate?

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private lazy var reviewView: ReviewView = {
        let reviewView = ReviewView()
        reviewView.delegate = self
        return reviewView
    }()

    var model: Model? {
        didSet {
            refreshSubviews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        refreshSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
        refreshSubviews()
    }

    private func setupSubviews() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(reviewView)

        LabelStyles.applyElementBoldTitleStyle(titleLabel)
    }

    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func refreshSubviews() {
        titleLabel.text = model?.title
        reviewView.model = model?.review
    }

    @objc func editLinkTapped() {
        delegate?.didSelectReviewEditing()
    }

    func didSelectReviewDetailsEditing() {
        delegate?.didSelectReviewEditing()
    }
}

extension OwnReviewView {
    struct Model {
        let title: String
        let review: ReviewView.Model
    }
}
