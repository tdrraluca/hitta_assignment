//
//  CompanyPresenter.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//
//

import UIKit

protocol CompanyPresentationLogic {
    func present(companyDetails: CompanyDetails)
    func present(companyDetailsError: Error)
    func present(ratingDetails: RatingDetails)
    func present(ratingDetailsError: Error)
    func present(ownReview: Review?)
    func presentReviewDetails()
}

class CompanyPresenter: CompanyPresentationLogic {
    weak var viewController: CompanyDisplayLogic?

    func present(companyDetails: CompanyDetails) {
        let displayModel = CompanyDisplayModel.CompanyDetails(name: companyDetails.name)
        viewController?.display(companyDetails: displayModel)
    }

    func present(companyDetailsError: Error) {
        let model = CompanyDisplayModel.Error(message: companyDetailsError.localizedDescription)
        viewController?.display(companyDetailsError: model)
    }

    func present(ratingDetails: RatingDetails) {
        let latestReviews: [CompanyDisplayModel.Review] = ratingDetails.latestReviews.map {
            let info = $0.timestamp.timestampFormat() + " - " + $0.source
            return CompanyDisplayModel.Review(username: $0.username,
                                              userPictureURL: $0.userPictureURL,
                                              reviewDetails: $0.reviewDetails,
                                              reviewInfo: info,
                                              rating: $0.rating.rawValue)
        }

        let ratingsCount = "from \(ratingDetails.ratingCount) ratings"

        let displayModel = CompanyDisplayModel.RatingDetails(rating: "\(ratingDetails.rating)",
                                                            ratingsCount: ratingsCount,
                                                            latestReviews: latestReviews)
        viewController?.display(ratingDetails: displayModel)
    }

    func present(ratingDetailsError: Error) {
        let model = CompanyDisplayModel.Error(message: ratingDetailsError.localizedDescription)
        viewController?.display(companyDetailsError: model)
    }

    func present(ownReview: Review?) {
        if let review = ownReview {
            let info = review.timestamp.timestampFormat() + " - " + review.source
            let reviewModel = CompanyDisplayModel.Review(username: review.username,
                                                         userPictureURL: nil,
                                                         reviewDetails: review.reviewDetails,
                                                         reviewInfo: info,
                                                         rating: review.rating.rawValue)
            viewController?.display(ownReview: CompanyDisplayModel.OwnReview.review(reviewModel))
        } else {
            let noReviewModel = CompanyDisplayModel.NoReview(profilePictureURL: nil)
            viewController?.display(ownReview: CompanyDisplayModel.OwnReview.none(noReviewModel))
        }
    }

    func presentReviewDetails() {
        viewController?.displayReviewDetails()
    }
}
