//
//  MALoginViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/23.
//

import UIKit
import RxSwift
import RxCocoa
import RAGTextField

class MALoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var uidTextField: RAGTextField! {
        didSet {
            setUp(uidTextField)
        }
    }

    @IBOutlet weak var pwdTextField: RAGTextField! {
        didSet {
            setUp(pwdTextField)
        }
    }

    @IBOutlet weak var loginButton: UIButton!

    private var viewModel: LoginViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let _ = uidTextField.becomeFirstResponder()
    }

    private func bindViewModel() {
        viewModel = .init(
            uid: uidTextField.rx.text.orEmpty.asObservable(),
            pwd: pwdTextField.rx.text.orEmpty.asObservable()
        )

        viewModel.uidValid
            .map { $0.isValidate }
            .bind(to: pwdTextField.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.uidValid.bind(to: uidTextField.rx.validationResult).disposed(by: disposeBag)
        viewModel.pwdValid.bind(to: pwdTextField.rx.validationResult).disposed(by: disposeBag)

        viewModel.allValid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }

    private func setUp(_ textField: RAGTextField) {
        textField.delegate = self
        textField.textColor = .midnight
        textField.tintColor = .midnight
        textField.textBackgroundView = makeTextBackgroundView()
        textField.textPadding = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        textField.textPaddingMode = .textAndPlaceholderAndHint
        textField.scaledPlaceholderOffset = 2.0
        textField.placeholderMode = .scalesWhenEditing
        textField.placeholderScaleWhenEditing = 0.8
        textField.placeholderColor = .stone
        textField.hintFont = .systemFont(ofSize: 10.0)
    }

    private func makeTextBackgroundView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 6.0
        view.backgroundColor = .chalk
        return view
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBAction func didClickLogin(_ sender: Any) {
        MALoginHelper.default().login(with: .username, userInfo: [
            kMALoginUserInfoKeyUsername: uidTextField.text ?? "",
            kMALoginUserInfoKeyPassword: pwdTextField.text ?? ""
        ]) {
            self.dismiss(animated: true)
        }
    }

}
