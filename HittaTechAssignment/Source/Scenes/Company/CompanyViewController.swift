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
    func displayCompanyDetails(_ model: CompanyDisplayModel.CompanyDetailsDisplayModel)
    func displayRatingDetails(_ model: CompanyDisplayModel.RatingDetails)
    func displayOwnReview(_ model: CompanyDisplayModel.OwnReview)
    func displayReviewPage()
    func displayErrorPopup()
}

class CompanyViewController: UIViewController {

    @IBOutlet weak var reviewsLoadingView: UIView!
    @IBOutlet weak var reviewsContentStackView: UIStackView!
    @IBOutlet weak var fullScreenLoadingView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var reviewsTitleLabel: UILabel!
    @IBOutlet weak var ownReviewView: UIView!
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

        reviewsContentStackView.setCustomSpacing(15.0, after: ownReviewView)

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
            ownReviewView.addSubview(rateAndReviewView)
            ownReviewView.addFillingConstraints(subview: rateAndReviewView)
        }
    }
}

extension CompanyViewController: CompanyDisplayLogic {

    func displayCompanyDetails(_ model: CompanyDisplayModel.CompanyDetailsDisplayModel) {
        companyNameLabel.text = model.name

        UIView.animate(withDuration: 0.3, animations: {
            self.fullScreenLoadingView.alpha = 0.0
        }, completion: { _ in
            self.fullScreenLoadingView.removeFromSuperview()
        })
    }

    func displayRatingDetails(_ model: CompanyDisplayModel.RatingDetails) {

        ratingsCountLabel.text = model.ratingsCount
        ratingLabel.text = model.rating
        ratingSummaryViewAllReviewsButton.setTitle(model.allReviewsLinkText, for: .normal)
        latestReviewsViewAllReviewsButton.setTitle(model.allReviewsLinkText, for: .normal)

        let latestReviewsModels: [ReviewView.Model] = model.latestReviews.enumerated().map {
            let model = ReviewView.Model(username: $0.element.username,
                                         rating: $0.element.rating,
                                         info: $0.element.reviewInfo,
                                         reviewText: $0.element.reviewText,
                                         profilePictureURL: $0.element.userPictureURL,
                                         shouldShowSeparator: $0.offset != model.latestReviews.count - 1)
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

    func displayOwnReview(_ model: CompanyDisplayModel.OwnReview) {
        switch model {
        case .none(let noReview):
            //uninstall review view
            installRateAndReviewViewIfNeeded()
            rateAndReviewView.model = RateAndReviewView.Model(title: noReview.title,
                                                              subtitle: noReview.subtitle,
                                                              profilePictureURL: noReview.profilePictureURL)
        default:
            break
        }
    }

    func displayReviewPage() {
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
