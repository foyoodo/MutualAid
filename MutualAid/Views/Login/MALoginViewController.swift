//
//  MALoginViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/23.
//

import UIKit
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let _ = uidTextField.becomeFirstResponder()
    }

    private func setUp(_ textField: RAGTextField) {
        textField.delegate = self
        textField.textColor = .init(hex: 0x34495E)
        textField.tintColor = .init(hex: 0x34495E)
        textField.textBackgroundView = makeTextBackgroundView()
        textField.textPadding = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        textField.textPaddingMode = .textAndPlaceholderAndHint
        textField.scaledPlaceholderOffset = 2.0
        textField.placeholderMode = .scalesWhenEditing
        textField.placeholderScaleWhenEditing = 0.8
        textField.placeholderColor = .init(hex: 0x95A5A6)
    }

    private func makeTextBackgroundView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 6.0
        view.backgroundColor = .init(hex: 0xECF0F1)
        return view
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBAction func didClickLogin(_ sender: Any) {
        MAUserDefaults.standard().userPicUrl = "https://lh3.googleusercontent.com/ogw/ADea4I6KMpBrLiKnhOyNOe_fmE3PmnHu9UclRR9ND9bD=s192-c-mo"
        MAUserDefaults.standard().userName = "foyoodo"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true)
            NotificationCenter.default.post(name: .maUserLoginStateChanged, object: nil, userInfo: [
                "isLogin": true
            ])
        }
    }
}
