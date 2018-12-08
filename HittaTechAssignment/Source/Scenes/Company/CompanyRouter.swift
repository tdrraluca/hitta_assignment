//
//  CompanyRouter.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//
//

import UIKit

protocol CompanyRoutingLogic {
    func routeToReviewPage()
}

protocol CompanyDataPassing {
    var dataStore: CompanyDataStore? { get }
}

class CompanyRouter: NSObject, CompanyRoutingLogic, CompanyDataPassing {
    weak var viewController: CompanyViewController?
    var dataStore: CompanyDataStore?

    // MARK: Routing

    func routeToReviewPage() {
        // swiftlint:disable force_cast
        let destinationVC = UIStoryboard(name: "Review", bundle: nil).instantiateInitialViewController() as! ReviewViewController
        // swiftlint:enable force_cast
        var destinationDS = destinationVC.router!.dataStore!
        passDataToReviewPage(source: dataStore!, destination: &destinationDS)
        navigateToReviewPage(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToReviewPage(source: CompanyViewController,
                              destination: ReviewViewController) {
        let navigationViewController = HittaNavigationController(rootViewController: destination)
        source.present(navigationViewController, animated: true, completion: nil)
    }

    // MARK: Passing data

    func passDataToReviewPage(source: CompanyDataStore,
                              destination: inout ReviewDataStore) {
        destination.currentRating = source.selectedRating
        destination.companyName = source.companyName
    }
}
