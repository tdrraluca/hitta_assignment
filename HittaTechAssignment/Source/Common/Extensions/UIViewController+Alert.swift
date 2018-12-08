//
//  UIViewController+Alert.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?,
                   message: String?,
                   cancelButtonTitle: String?,
                   cancelHandler: (() -> Void)?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel,
                                         handler: { _ in
            cancelHandler?()
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
