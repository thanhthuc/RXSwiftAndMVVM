//
//  UIProtocol.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import RxSwift

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

protocol BindableView {
    associatedtype V
    func bindViewModel(viewModel: V)
}

protocol NibProviable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension NibProviable {
    static var nibName: String { 
        return "\(self)"
    }
    
    static var nib: UINib { 
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T? where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Something wrong for reuse cell")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T? where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Something wrong for reuse cell")
        }
        return cell
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T? where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Something wrong for reuse cell")
        }
        return cell
    }
}







