//
//  Review.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

enum Rating: Int {
    case oneStar = 1
    case twoStars
    case threeStars
    case fourStars
    case fiveStars

    var description: String {
        switch self {
        case .oneStar:
            return "I hated it"
        case .twoStars:
            return "I didn't like it"
        case .threeStars:
            return "It was OK"
        case .fourStars:
            return "I liked it"
        case .fiveStars:
            return "I loved it"
        }
    }
}

struct Review {
    let username: String
    let userPictureURL: URL?
    let timestamp: Date
    let source: String
    let reviewDetails: String?
    let rating: Rating
}

struct RatingDetails {
    let rating: Float
    let ratingCount: Int
    let latestReviews: [Review]
}
