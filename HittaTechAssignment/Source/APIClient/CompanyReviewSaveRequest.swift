//
//  CompanyReviewSave.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 10/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

struct CompanyReviewSaveRequest: Request {

    typealias AssociatedResponse = CompanyReviewSaveResponse

    private let review: Review

    init(review: Review) {
        self.review = review
    }

    var url: URL {
        return URL(string: "https://test.hitta.se/reviews/v1/company")!
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var contentType: ContentType {
        return .URLEncoded
    }

    var headers: [String: String]? {
        return ["X-HITTA-DEVICE-NAME": "MOBILE_WEB",
                "X-HITTA-SHARED-IDENTIFIER": "15188693697264027"]
    }

    var parameters: [String: Any]? {
        var parameters: [String: Any] = ["score": review.rating.rawValue,
                                         "companyId": "ctyfiintu",
                                         "userName": review.username]
        if let reviewDetails = review.reviewDetails, !reviewDetails.isEmpty {
            parameters["comment"] = reviewDetails
        }
        return parameters
    }
}

struct CompanyReviewSaveResponse: Response {
    init?(data: Data?) {}
}
