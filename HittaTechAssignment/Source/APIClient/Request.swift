//
//  Request.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 01/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get
    case post
}

enum ContentType {
    case JSON
    case URLEncoded
}

protocol Request {
    associatedtype AssociatedResponse: Response

    var url: URL { get }

    var httpMethod: HTTPMethod { get }

    var parameters: [String: Any]? { get }

    var contentType: ContentType { get }

    var headers: [String: String]? { get }
}

extension Request {

    var httpMethod: HTTPMethod {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var contentType: ContentType {
        return .JSON
    }

    var headers: [String: String]? {
        return nil
    }
}

struct CompanyDetailsRequest: Request {
    typealias AssociatedResponse = CompanyDetailsResponse
    var url: URL {
        return URL(string: "https://api.hitta.se/search/v7/app/company/ctyfiintu")!
    }
}
