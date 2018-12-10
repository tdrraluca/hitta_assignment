//
//  CompanyViewController.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//
//

import UIKit

protocol CompanyDisplayLogic: class {
    func display(companyDetails: CompanyDisplayModel.CompanyDetailsDisplayModel)
    func display(ratingDetails: CompanyDisplayModel.RatingDetails)
    func display(ownReview: CompanyDisplayModel.OwnReview)
    func displayReviewDetails()
    func displayErrorPopup()
}

class CompanyViewController: UIViewController {

    @IBOutlet weak var reviewsLoadingView: UIView!
    @IBOutlet weak var reviewsContentStackView: UIStackView!
    @IBOutlet weak var fullScreenLoadingView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var reviewsTitleLabel: UILabel!
    @IBOutlet weak var ownReviewContainer: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var ratingSummaryViewAllReviewsButton: UIButton!
    @IBOutlet weak var ratingSummarySeparatorView: UIView!
    @IBOutlet weak var latestReviewsTitleLabel: UILabel!
    @IBOutlet weak var latestReviewsStackView: UIStackView!
    @IBOutlet weak var latestReviewsViewAllReviewsButton: UIButton!

    private lazy var rateAndReviewView: RateAndReviewView = {
        let rateAndReviewView = RateAndReviewView()
        rateAndReviewView.delegate = self
        return rateAndReviewView
    } ()

    private lazy var ownReviewView: OwnReviewView = {
        let ownReviewView = OwnReviewView()
        ownReviewView.delegate = self
        return ownReviewView
    } ()

    var interactor: CompanyBusinessLogic?
    var router: (CompanyRoutingLogic & CompanyDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

  // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = CompanyInteractor()
        let presenter = CompanyPresenter()
        let router = CompanyRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsLoadingView.isHidden = false
        reviewsContentStackView.isHidden = true

        reviewsContentStackView.setCustomSpacing(15.0, after: ownReviewContainer)

        applyStyle()

        loadCompanyDetails()
        loadRatingDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        interactor?.getOwnReview()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Data loading

    private func loadCompanyDetails() {
        interactor?.getCompanyDetails()
    }

    private func loadRatingDetails() {
        ratingSummaryViewAllReviewsButton.setTitle("View all reviews", for: .normal)
        latestReviewsViewAllReviewsButton.setTitle("View all reviews", for: .normal)

        interactor?.getRatingDetails()
    }

    private func applyStyle() {
        LabelStyles.applyHeaderStyle(companyNameLabel)
        LabelStyles.applyHeaderStyle(reviewsTitleLabel)
        LabelStyles.applyBoxHighlightedStyle(ratingLabel)
        LabelStyles.applyNoteStyle(ratingsCountLabel)
        LabelStyles.applyElementBoldTitleStyle(latestReviewsTitleLabel)

        ButtonStyles.applyLinkStyle(ratingSummaryViewAllReviewsButton)
        ButtonStyles.applyEmphasisedLinkStyle(latestReviewsViewAllReviewsButton)

        ratingSummarySeparatorView.backgroundColor = ColorPalette.separatorGray
    }

    private func installRateAndReviewViewIfNeeded() {
        if rateAndReviewView.superview == nil {
            ownReviewContainer.addSubview(rateAndReviewView)
            ownReviewContainer.addFillingConstraints(subview: rateAndReviewView)
        }
    }

    private func installOwnReviewViewIfNeeded() {
        if ownReviewView.superview == nil {
            ownReviewContainer.addSubview(ownReviewView)
            ownReviewContainer.addFillingConstraints(subview: ownReviewView)
        }
    }
}

extension CompanyViewController: CompanyDisplayLogic {

    func display(companyDetails: CompanyDisplayModel.CompanyDetailsDisplayModel) {
        companyNameLabel.text = companyDetails.name

        UIView.animate(withDuration: 0.3, animations: {
            self.fullScreenLoadingView.alpha = 0.0
        }, completion: { _ in
            self.fullScreenLoadingView.removeFromSuperview()
        })
    }

    func display(ratingDetails: CompanyDisplayModel.RatingDetails) {

        ratingsCountLabel.text = ratingDetails.ratingsCount
        ratingLabel.text = ratingDetails.rating

        let latestReviewsModels: [ReviewView.Model] = ratingDetails.latestReviews.enumerated().map {
            let shouldHideSeparator = $0.offset == ratingDetails.latestReviews.count - 1
            let model = ReviewView.Model(username: $0.element.username,
                                         rating: $0.element.rating,
                                         info: $0.element.reviewInfo,
                                         reviewDetails: $0.element.reviewDetails,
                                         profilePictureURL: $0.element.userPictureURL,
                                         shouldHideSeparator: shouldHideSeparator,
                                         editLinkText: nil,
                                         shouldShowEditDetailsLink: false)
            return model
        }

        for model in latestReviewsModels {
            let reviewView = ReviewView(frame: .zero)
            reviewView.model = model
            latestReviewsStackView.addArrangedSubview(reviewView)
        }

        reviewsContentStackView.isHidden = false
        reviewsLoadingView.isHidden = true
    }

    func display(ownReview: CompanyDisplayModel.OwnReview) {
        switch ownReview {
        case .none(let noReview):
            ownReviewView.removeFromSuperview()
            installRateAndReviewViewIfNeeded()
            rateAndReviewView.model = RateAndReviewView.Model(title: "Rate and review",
                                                              subtitle: "Share your experience to help others",
                                                              profilePictureURL: noReview.profilePictureURL)
        case .review(let review):
            rateAndReviewView.removeFromSuperview()
            installOwnReviewViewIfNeeded()

            let reviewModel = ReviewView.Model(username: review.username,
                                               rating: review.rating,
                                               info: review.reviewInfo,
                                               reviewDetails: review.reviewDetails,
                                               profilePictureURL: review.userPictureURL,
                                               shouldHideSeparator: false,
                                               editLinkText: "Describe your experience",
                                               shouldShowEditDetailsLink: true)
            let ownReviewModel = OwnReviewView.Model.init(title: "Your review",
                                                          review: reviewModel)
            ownReviewView.model = ownReviewModel
        }
    }

    func displayReviewDetails() {
        router?.routeToReviewPage()
    }

    func displayErrorPopup() {

    }
}

extension CompanyViewController: RateAndReviewViewDelegate {
    func didSelect(rating: Int) {
        interactor?.select(rating: rating)
    }
}

extension CompanyViewController: OwnReviewViewDelegate {
    func didSelectReviewEditing() {
        router?.routeToReviewPage()
    }
}
