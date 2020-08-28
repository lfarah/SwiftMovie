//
//  Extensions.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Rx
// https://gist.github.com/alskipp/e71f014c8f8a9aa12b8d8f8053b67d72
public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

extension Observable where Element: OptionalType {
    
    /// Returns safely unwrapped observable
    func filterNotNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension BehaviorRelay where Element: OptionalType {
    
    /// Returns safely unwrapped observable
    func filterNotNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

// MARK: - Tableview
public protocol ReusableView: class { }

extension UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    /// Registers cell for tableview using a Type
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }
        
    /// Dequeue cell for tableview using a Type
    public func dequeueResuableCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(" Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
