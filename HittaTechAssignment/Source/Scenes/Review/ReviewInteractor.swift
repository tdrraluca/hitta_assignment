//
//  ReviewInteractor.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol ReviewBusinessLogic {
}

protocol ReviewDataStore {
    var currentRating: Int? { get set }
    var companyName: String? { get set }
}

class ReviewInteractor: ReviewBusinessLogic, ReviewDataStore {
    var presenter: ReviewPresentationLogic?

    var currentRating: Int?
    var companyName: String?
}
