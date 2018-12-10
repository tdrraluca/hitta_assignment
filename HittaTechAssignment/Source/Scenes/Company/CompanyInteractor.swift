//
//  CompanyInteractor.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol CompanyBusinessLogic {
    func getCompanyDetails()
    func getRatingDetails()
    func getOwnReview()
    func select(rating: Int)
}

protocol CompanyDataStore {
    var companyName: String? { get }
    var ownReview: Review? { get set }
    var selectedRating: Rating? { get }
}

class CompanyInteractor: CompanyBusinessLogic, CompanyDataStore {

    var presenter: CompanyPresentationLogic?
    let companyDetailsWorker = CompanyDetailsWorker()
    let companyReviewsWorker = CompanyReviewsWorker()

    var ownReview: Review?

    private (set) var companyName: String?
    private (set) var selectedRating: Rating?

    func getCompanyDetails() {
        companyDetailsWorker.getCompanyDetails { [weak self] result in
            guard let strongSelf = self  else {
                return
            }

            switch result {
            case .success(let companyDetails):
                strongSelf.companyName = companyDetails.name
                strongSelf.presenter?.present(companyDetails: companyDetails)
            case .failure(let error):
                strongSelf.presenter?.present(error: error)
            }
        }
    }

    func getRatingDetails() {
        companyReviewsWorker.getCompanyRatingDetails { [weak self] result in
            guard let strongSelf = self  else {
                return
            }

            switch result {
            case .success(let ratingDetails):
                let sortedLatestReviews = ratingDetails.latestReviews.sorted(by: { return $0.timestamp > $1.timestamp })
                let updatedRatingDetails = RatingDetails(rating: ratingDetails.rating,
                                                         ratingCount: ratingDetails.ratingCount,
                                                         latestReviews: sortedLatestReviews)
                strongSelf.presenter?.present(ratingDetails: updatedRatingDetails)
            case .failure(let error):
                strongSelf.presenter?.present(error: error)
            }
        }
    }

    func getOwnReview() {
        presenter?.present(ownReview: ownReview)
    }

    func select(rating: Int) {
        guard let selectedRating = Rating(rawValue: rating) else {
            preconditionFailure("Invalid rating")
        }
        self.selectedRating = selectedRating
        presenter?.presentReviewDetails()
    }
}
