//
//  ReviewPresenter.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol ReviewPresentationLogic {
    func present(companyName: String?)
    func present(rating: Rating?)
    func present(review: Review)
    func presentCompanyPage()
}

class ReviewPresenter: ReviewPresentationLogic {
    weak var viewController: ReviewDisplayLogic?

    func present(companyName: String?) {
        viewController?.display(companyName: companyName)
    }

    func present(rating: Rating?) {
        var displayModel: ReviewDisplayModel.Rating?
        if let rating = rating {
            displayModel = ReviewDisplayModel.Rating(value: rating.rawValue,
                                                    description: rating.description)
        }

        viewController?.display(rating: displayModel)
    }

    func present(review: Review) {
        let rating = ReviewDisplayModel.Rating(value: review.rating.rawValue,
                                               description: review.rating.description)
        let review = ReviewDisplayModel.Review(rating: rating,
                                               username: review.username,
                                               details: review.reviewText)
        viewController?.display(review: review)
    }

    func presentCompanyPage() {
        viewController?.displayCompanyPage()
    }
}
