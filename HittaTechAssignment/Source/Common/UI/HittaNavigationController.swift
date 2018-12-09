//
//  HittaNavigationController.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

class HittaNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        navigationBar.barTintColor = ColorPalette.navigationBlue
        navigationBar.tintColor = ColorPalette.white
        let titleAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.white]
        navigationBar.titleTextAttributes = titleAttributes
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
