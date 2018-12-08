//
//  Result.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 02/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
