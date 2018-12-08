//
//  CompanyDetailsWorker.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import Foundation

class CompanyDetailsWorker {
    func getCompanyDetails(completion: @escaping(Result<CompanyDetails>) -> Void) {
        APIClient().perform(request: CompanyDetailsRequest()) { result in
            switch result {
            case .success(let response):
                let companyName = response.result.name
                let companyDetails = CompanyDetails(name: companyName)
                completion(.success(companyDetails))
            case .failure(let error):
                completion(.failure(.apiClientError(message: error.localizedDescription)))
            }
        }
    }
}
