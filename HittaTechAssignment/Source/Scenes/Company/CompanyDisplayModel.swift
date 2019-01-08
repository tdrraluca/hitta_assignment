//
//  CompanyDisplayModel.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

struct CompanyDisplayModel {
    struct CompanyDetails {
        let name: String
    }

    struct Review {
        let username: String
        let userPictureURL: URL?
        let reviewDetails: String?
        let reviewInfo: String
        let rating: Int
    }

    struct RatingDetails {
        let rating: String
        let ratingsCount: String
        let latestReviews: [Review]
    }

    struct NoReview {
        let profilePictureURL: URL?
    }

    enum OwnReview {
        case none(NoReview)
        case review(Review)
    }

    struct Error {
        let message: String
    }
}
