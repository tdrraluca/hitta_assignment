//
//  CompanyRatingDetailsWorker.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

class CompanyReviewsWorker {
    func getCompanyRatingDetails(completion: @escaping(Result<RatingDetails>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            completion(.success(self.ratingMockData()))
        })
    }

    func saveReview(review: Review) {
        APIClient().perform(request: CompanyReviewSaveRequest(review: review)) { _ in }
    }

    private func ratingMockData() -> RatingDetails {
        var reviews = [Review]()
        reviews.append(Review(username: "Anonymous",
                              userPictureURL: nil,
                              timestamp: Date().addingTimeInterval(-3600 * 12),
                              source: "hitta.se",
                              reviewDetails: "Liked it very much - probably one of the best burger places in the city - recommend",
                              rating: .fourStars))

        reviews.append(Review(username: "Jenny Svensson",
                              userPictureURL: nil,
                              timestamp: Date().addingTimeInterval(-3600 * 24),
                              source: "hitta.se",
                              reviewDetails: "Maybe a bit too fast food. I personally dislike that. Good otherwise",
                              rating: .threeStars))

        reviews.append(Review(username: "happy56",
                              userPictureURL: nil,
                              timestamp: Date().addingTimeInterval(-3600 * 24),
                              source: "yelp.com",
                              reviewDetails: "Super good! Love the food!",
                              rating: .fiveStars))
        return RatingDetails(rating: 4.1, ratingCount: 27, latestReviews: reviews)
    }
}
