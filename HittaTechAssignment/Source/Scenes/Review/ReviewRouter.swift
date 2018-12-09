//
//  ReviewRouter.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol ReviewRoutingLogic: class {
    func routeToCompanyPage()
}

protocol ReviewDataPassing {
    var dataStore: ReviewDataStore? { get }
}

class ReviewRouter: NSObject, ReviewRoutingLogic, ReviewDataPassing {
    weak var viewController: ReviewViewController?
    var dataStore: ReviewDataStore?

    func routeToCompanyPage() {
        // swiftlint:disable force_cast
        let destinationVC = viewController?.presentingViewController as! CompanyViewController
        // swiftlint:enable force_cast
        var destinationDS = destinationVC.router!.dataStore!
        passDataToReviewPage(source: dataStore!, destination: &destinationDS)
        navigateToCompanyPage()
    }

    func navigateToCompanyPage() {
        viewController!.dismiss(animated: true, completion: nil)
    }

    // MARK: Passing data

    func passDataToReviewPage(source: ReviewDataStore,
                              destination: inout CompanyDataStore) {
        destination.ownReview = source.review
    }
}
