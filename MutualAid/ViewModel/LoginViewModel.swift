//
//  LoginViewModel.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/23.
//

import UIKit
import RxSwift
import RxCocoa
import RAGTextField

private let minUidCount = 3
private let minPwdCount = 5

class LoginViewModel: NSObject {
    let uidValid: Observable<ValidationResult>
    let pwdValid: Observable<ValidationResult>
    let allValid: Observable<Bool>

    init(uid: Observable<String>, pwd: Observable<String>) {
        uidValid = uid
            .map {
                if $0.isEmpty {
                    return .empty
                }
                if $0.count < minUidCount {
                    return .failed(message: "用户名无效")
                }
                return .ok(message: "用户名有效")
            }
            .share(replay: 1)

        pwdValid = pwd
            .map {
                if $0.isEmpty {
                    return .empty
                }
                if $0.count < minPwdCount {
                    return .failed(message: "密码长度不能小于\(minPwdCount)位")
                }
                return .ok(message: "密码有效")
            }
            .share(replay: 1)

        allValid = .combineLatest(uidValid, pwdValid) { $0.isValidate && $1.isValidate } .share(replay: 1)
    }
}

enum ValidationResult {
    case empty
    case validating
    case ok(message: String)
    case failed(message: String)
}

extension ValidationResult {
    var isValidate: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }

    var description: String? {
        switch self {
        case .empty:
            return nil
        case .validating:
            return "加载中..."
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }

    var textColor: UIColor {
        switch self {
        case .ok:
            return .accent
        case .failed:
            return .systemRed
        default:
            return .black
        }
    }
}

extension Reactive where Base: RAGTextField {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { textField, result in
            textField.hint = result.description
            textField.hintColor = result.textColor
        }
    }
}
