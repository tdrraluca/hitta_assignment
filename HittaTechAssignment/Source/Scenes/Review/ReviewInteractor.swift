//
//  ReviewInteractor.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol ReviewBusinessLogic {
    func getCompanyName()
    func getReviewData()
    func select(rating: Int)
    func concludeReview(username: String?, details: String?, isSave: Bool)
}

protocol ReviewDataStore {
    var selectedRating: Rating? { get set }
    var companyName: String? { get set }
    var review: Review? { get set }
}

class ReviewInteractor: ReviewBusinessLogic, ReviewDataStore {
    var presenter: ReviewPresentationLogic?

    let companyReviewsWorker = CompanyReviewsWorker()

    var selectedRating: Rating?
    var companyName: String?
    var review: Review?

    func getCompanyName() {
        presenter?.present(companyName: companyName)
    }

    func getReviewData() {
        if let review = review {
            presenter?.present(review: review)
        } else {
            presenter?.present(rating: selectedRating)
        }
    }

    func select(rating: Int) {
        guard let selectedRating = Rating(rawValue: rating) else {
            preconditionFailure("Invalid rating")
        }
        self.selectedRating = selectedRating
        presenter?.present(rating: selectedRating)
    }

    func concludeReview(username: String?, details: String?, isSave: Bool) {
        guard let rating = selectedRating else {
            presenter?.presentCompanyPage()
            return
        }
        let user = username?.isEmpty == false ? username! : "Anonymous"
        let review = Review(username: user,
                            userPictureURL: nil,
                            timestamp: Date(),
                            source: "hitta.se",
                            reviewDetails: details,
                            rating: rating)
        if isSave {
            companyReviewsWorker.saveReview(review: review) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                switch result {
                case .success:
                    strongSelf.presenter?.presentCompanyPage()
                case .failure(let error):
                    strongSelf.presenter?.present(reviewSaveError: error)
                }
            }
        } else {
            self.presenter?.presentCompanyPage()
        }
        self.review = review
    }
}
