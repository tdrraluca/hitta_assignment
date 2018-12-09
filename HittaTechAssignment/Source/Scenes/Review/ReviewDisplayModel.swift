//
//  ReviewDisplayModel.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 09/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

struct ReviewDisplayModel {
    struct Rating {
        let value: Int
        let description: String
    }

    struct Review {
        let rating: Rating
        let username: String?
        let details: String?
    }
}
