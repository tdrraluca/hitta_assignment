//
//  Review.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

enum Rating: Int {
    case oneStar
    case twoStars
    case threeStars
    case fourStars
    case fiveStars
}

struct Review {
    let username: String
    let userPictureURL: URL?
    let timestamp: Date
    let source: String
    let reviewText: String?
    let rating: Rating
}

struct RatingDetails {
    let rating: Float
    let ratingCount: Int
    let latestReviews: [Review]
}
