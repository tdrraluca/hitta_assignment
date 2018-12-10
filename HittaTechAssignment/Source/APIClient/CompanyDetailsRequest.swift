//
//  CompanyDetails.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 10/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

struct CompanyDetailsRequest: Request {
    typealias AssociatedResponse = CompanyDetailsResponse

    var url: URL {
        return URL(string: "https://api.hitta.se/search/v7/app/company/ctyfiintu")!
    }
}

struct CompanyDetailsResponse: Response {

    struct CompanyDetails: Decodable {
        let name: String

        enum RootCodingKeys: String, CodingKey {
            case result
        }

        enum CompaniesCodingKeys: String, CodingKey {
            case companies
        }

        enum CompanyCodingKeys: String, CodingKey {
            case company
        }

        enum CompanyDetailsKeys: String, CodingKey {
            case displayName
        }

        init(from decoder: Decoder) throws {
            let rootObject = try decoder.container(keyedBy: RootCodingKeys.self)
            let resultObject = try rootObject.nestedContainer(keyedBy: CompaniesCodingKeys.self, forKey: .result)
            let companiesObject = try resultObject.nestedContainer(keyedBy: CompanyCodingKeys.self, forKey: .companies)
            var companyArray = try companiesObject.nestedUnkeyedContainer(forKey: .company)
            let companyDetailsObject = try companyArray.nestedContainer(keyedBy: CompanyDetailsKeys.self)
            name = try companyDetailsObject.decode(String.self, forKey: .displayName)
        }
    }

    let result: CompanyDetails

    init?(data: Data?) {
        guard let data = data else {
            return nil
        }
        do {
            result = try JSONDecoder().decode(CompanyDetails.self, from: data)
        } catch {
            return nil
        }
    }
}
