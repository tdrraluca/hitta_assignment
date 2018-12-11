//
//  ReviewViewController.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright (c) 2018 Raluca Toadere. All rights reserved.
//

import UIKit

protocol ReviewDisplayLogic: class {
    func display(companyName: String?)
    func display(rating: ReviewDisplayModel.Rating?)
    func display(review: ReviewDisplayModel.Review)
    func displayCompanyPage()
    func display(reviewSaveError: ReviewDisplayModel.Error)
}

class ReviewViewController: UIViewController {
    var interactor: ReviewBusinessLogic?
    var router: (NSObjectProtocol & ReviewRoutingLogic & ReviewDataPassing)?

    @IBOutlet weak var ratingViewContainer: UIView!
    @IBOutlet weak var ratingDescriptionLabel: UILabel!

    @IBOutlet weak var usernameTextFieldTopBorder: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameTextFieldBottomBorder: UIView!
    @IBOutlet weak var reviewDetailsTextView: UITextView!
    @IBOutlet weak var reviewDetailsPlaceholderLabel: UILabel!
    @IBOutlet weak var reviewDetailsTextViewBottomBorder: UIView!

    private lazy var ratingView: RatingView = {
        let selectedImage = UIImage(named: "filled_star_big")!
        let unselectedImage = UIImage(named: "empty_star_big")!
        let ratingViewModel = RatingView.Model(maxRating: 5,
                                               currentRating: 0,
                                               selectedImage: selectedImage,
                                               unselectedImage: unselectedImage)
        return RatingView(frame: .zero, model: ratingViewModel)
    }()

    private lazy var loadingView: UIView  = {
        let view = UIView()
        view.backgroundColor = ColorPalette.transparentWhite
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func loadView() {
        super.loadView()

        ratingViewContainer.addSubview(ratingView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ratingView.delegate = self
        reviewDetailsTextView.delegate = self
        reviewDetailsPlaceholderLabel.text = "Add more details on your experience..."

        setupNavigationBar()
        setupConstraints()
        applyStyle()

        interactor?.getReviewData()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ReviewInteractor()
        let presenter = ReviewPresenter()
        let router = ReviewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
  }

    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(title: "Close",
                                          style: .plain,
                                          target: self,
                                          action: #selector(closeButtonTapped))
        closeButton.setTitleTextAttributes(AttributedStrings.navigationBarAttributes(), for: .normal)
        navigationItem.leftBarButtonItem = closeButton

        let saveButton = UIBarButtonItem(title: "Save",
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveButtonTapped))
        saveButton.setTitleTextAttributes(AttributedStrings.navigationBarAttributes(), for: .normal)
        navigationItem.rightBarButtonItem = saveButton
        interactor?.getCompanyName()
    }

    private func setupConstraints() {
        ratingViewContainer.addFillingConstraints(subview: ratingView)
    }

    private func applyStyle() {
        usernameTextFieldTopBorder.backgroundColor = ColorPalette.separatorGray
        usernameTextFieldBottomBorder.backgroundColor = ColorPalette.separatorGray
        reviewDetailsTextViewBottomBorder.backgroundColor = ColorPalette.separatorGray

        LabelStyles.applyNoteStyle(ratingDescriptionLabel)
        LabelStyles.applyPlaceholderStyle(reviewDetailsPlaceholderLabel)

        TextFieldStyles.applyHittaStyle(usernameTextField)
        usernameTextField.attributedPlaceholder = AttributedStrings.placeholderAttributedString(value: "Your name")

        TextViewStyles.applyHittaStyle(reviewDetailsTextView)
    }

    @objc func closeButtonTapped() {
        showCancelActionSheet()
    }

    @objc func saveButtonTapped() {
        showSavedAlert()
    }

    private func showCancelActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let exitAndSaveAction = UIAlertAction(title: "Exit and save your review",
                                              style: .default) { _ in
            self.saveReview()
        }
        actionSheet.addAction(exitAndSaveAction)

        let exitWithoutSavingAction = UIAlertAction(title: "Exit without saving",
                                                    style: .destructive) { _ in
            self.interactor?.concludeReview(username: self.usernameTextField.text,
                                            details: self.reviewDetailsTextView.text,
                                            isSave: false)
        }
        actionSheet.addAction(exitWithoutSavingAction)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }

    private func showSavedAlert() {
        showAlert(title: "Thank you for your review",
                  message: "You're helping others make smarter decisions every day",
                  cancelButtonTitle: "Okay!",
                  cancelHandler: {
            self.saveReview()
        })
    }

    private func saveReview() {
        showLoadingView()
        self.interactor?.concludeReview(username: self.usernameTextField.text,
                                        details: self.reviewDetailsTextView.text,
                                        isSave: true)
    }

    private func showLoadingView() {
        view.addSubview(loadingView)
        view.addFillingConstraints(subview: loadingView)
    }

    private func hideLoadingView(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0.0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
            self.loadingView.alpha = 1.0
            completion()
        })
    }
}

extension ReviewViewController: ReviewDisplayLogic {
    func display(companyName: String?) {
        navigationItem.title = companyName
    }

    func display(rating: ReviewDisplayModel.Rating?) {
        ratingView.update(rating: rating?.value)
        ratingDescriptionLabel.text = rating?.description
    }

    func display(review: ReviewDisplayModel.Review) {
        ratingView.update(rating: review.rating.value)
        ratingDescriptionLabel.text = review.rating.description
        usernameTextField.text = review.username
        reviewDetailsTextView.text = review.details
        reviewDetailsPlaceholderLabel.isHidden = (review.details?.isEmpty == false)
    }

    func displayCompanyPage() {

        hideLoadingView(completion: {
            self.router?.routeToCompanyPage()
        })
    }

    func display(reviewSaveError: ReviewDisplayModel.Error) {
        showAlert(title: nil,
                  message: reviewSaveError.message,
                  cancelButtonTitle: "OK",
                  cancelHandler: nil)
    }
}

extension ReviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString?
        let updatedText = currentText?.replacingCharacters(in: range, with: text)
        reviewDetailsPlaceholderLabel.isHidden = (updatedText?.isEmpty == false)

        return true
    }
}

extension ReviewViewController: RatingViewDelegate {
    func didSelect(rating: Int) {
        interactor?.select(rating: rating)
    }
}
