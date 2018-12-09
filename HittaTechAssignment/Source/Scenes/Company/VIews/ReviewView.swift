//
//  ReviewView.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 07/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit
import Kingfisher

protocol ReviewViewDelegate: class {
    func didSelectReviewDetailsEditing()
}

class ReviewView: UIView {

    var model: Model? {
        didSet {
            refreshSubviews()
        }
    }

    weak var delegate: ReviewViewDelegate?

    private let usernameLabel = UILabel()
    private let infoLabel = UILabel()
    private let profilePictureImageView = ProfilePictureImageView(image: nil)
    private let detailsStackView = UIStackView()
    private let reviewDetailsLabel = UILabel()
    private let reviewDetailsEditButton = UIButton()
    private let separatorView = UIView()
    private let ratingView: RatingView = {
        let selectedImage = UIImage(named: "filled_star_small")!
        let unselectedImage = UIImage(named: "empty_star_small")!
        let ratingViewModel = RatingView.Model(maxRating: 5,
                                               currentRating: nil,
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
        addSubview(usernameLabel)
        addSubview(ratingView)
        addSubview(infoLabel)
        addSubview(detailsStackView)
        addSubview(separatorView)

        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fill
        detailsStackView.alignment = .leading

        detailsStackView.addArrangedSubview(reviewDetailsLabel)
        detailsStackView.addArrangedSubview(reviewDetailsEditButton)

        ratingView.isUserInteractionEnabled = false
        separatorView.backgroundColor = ColorPalette.separatorGray
        LabelStyles.applyElementMediumTitleStyle(usernameLabel)
        LabelStyles.applyNoteStyle(infoLabel)
        LabelStyles.applyTextBlockStyle(reviewDetailsLabel)
        ButtonStyles.applyLinkStyle(reviewDetailsEditButton)

        reviewDetailsEditButton.addTarget(self, action: #selector(detailsEditButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        profilePictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        profilePictureImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 15).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor).isActive = true
        ratingView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 60).isActive = true

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true

        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor).isActive = true
        detailsStackView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 11).isActive = true
        detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true

        reviewDetailsEditButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    private func refreshSubviews() {
        profilePictureImageView.kf.setImage(with: model?.profilePictureURL, placeholder: UIImage(named: "profile_default"))
        usernameLabel.text = model?.username
        ratingView.update(rating: model?.rating)
        infoLabel.text = model?.info
        reviewDetailsLabel.text = model?.reviewDetails
        reviewDetailsEditButton.setTitle(model?.editLinkText, for: .normal)

        if model?.reviewDetails?.isEmpty == false {
            reviewDetailsEditButton.isHidden = true
        } else {
            reviewDetailsEditButton.isHidden = !(model?.shouldShowEditDetailsLink == true)
        }

        separatorView.isHidden = model?.shouldHideSeparator == true
    }

    @objc func detailsEditButtonTapped() {
        delegate?.didSelectReviewDetailsEditing()
    }
}

extension ReviewView {
    struct Model {
        let username: String
        let rating: Int
        let info: String
        let reviewDetails: String?
        let profilePictureURL: URL?
        let shouldHideSeparator: Bool
        let editLinkText: String?
        let shouldShowEditDetailsLink: Bool
    }
}
