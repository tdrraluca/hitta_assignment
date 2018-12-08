//
//  RateAndReviewView.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit
import Kingfisher

protocol RateAndReviewViewDelegate: class {
    func didSelect(rating: Int)
}

class RateAndReviewView: UIView {

    var model: Model? {
        didSet {
            refreshSubviews()
        }
    }

    weak var delegate: RateAndReviewViewDelegate?

    private let profilePictureImageView = ProfilePictureImageView(image: nil)
    private let titleLabel = UILabel()
    private let subtitleTable = UILabel()
    private let separatorView = UIView()
    private let ratingView: RatingView = {
        let selectedImage = UIImage(named: "filled_star_big")!
        let unselectedImage = UIImage(named: "empty_star_big")!
        let ratingViewModel = RatingView.Model(maxRating: 5,
                                               currentRating: 0,
                                               selectedImage: selectedImage,
                                               unselectedImage: unselectedImage)
        return RatingView(frame: .zero, model: ratingViewModel)
    }()

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
        addSubview(profilePictureImageView)
        addSubview(titleLabel)
        addSubview(subtitleTable)
        addSubview(ratingView)
        addSubview(separatorView)

        ratingView.delegate = self

        LabelStyles.applyElementBoldTitleStyle(titleLabel)
        LabelStyles.applyNoteStyle(subtitleTable)
        separatorView.backgroundColor = ColorPalette.separatorGray
    }

    private func setupConstraints() {
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        profilePictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 21).isActive = true
        profilePictureImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        subtitleTable.translatesAutoresizingMaskIntoConstraints = false
        subtitleTable.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleTable.setContentHuggingPriority(.defaultLow + 1, for: .vertical)

        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        ratingView.topAnchor.constraint(equalTo: subtitleTable.bottomAnchor, constant: 14).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    private func refreshSubviews() {
        titleLabel.text = model?.title
        subtitleTable.text = model?.subtitle
        profilePictureImageView.kf.setImage(with: model?.profilePictureURL, placeholder: UIImage(named: "profile_default"))
    }
}

extension RateAndReviewView {
    struct Model {
        let title: String?
        let subtitle: String?
        let profilePictureURL: URL?
    }
}

extension RateAndReviewView: RatingViewDelegate {
    func didSelect(rating: Int) {
        delegate?.didSelect(rating: rating)
    }
}
