//
//  BindAbleCell.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit

typealias BindableCell = NibProviable & BindableView & ReusableView

struct BindableCellFactory<Cell: BindableCell, ViewModel> where Cell.V == ViewModel {}

extension BindableCellFactory where Cell: UITableViewCell {
    static func setupTableViewCellFromNib(dataSource: UITableViewDataSource,
                                     tableView: UITableView,
                                     indexPath: IndexPath,
                                     viewModel: ViewModel) -> UITableViewCell {
        
        guard let cell: Cell = tableView.dequeueReusableCell() else {
            tableView.register(Cell.nib, 
                               forCellReuseIdentifier: Cell.reuseIdentifier)
            return setupTableViewCellFromNib(dataSource: dataSource,
                                        tableView: tableView, 
                                        indexPath: indexPath, 
                                        viewModel: viewModel)
        }
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }
}

extension BindableCellFactory where Cell: UICollectionViewCell {
    static func setupCollectionViewCellFromNib(dataSource: UICollectionViewDataSource,
                                               collectionView: UICollectionView,
                                               indexPath: IndexPath,
                                               viewModel: ViewModel) -> UICollectionViewCell {
        
        guard let cell: Cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) else {
            collectionView.register(Cell.nib, forCellWithReuseIdentifier: Cell.reuseIdentifier)
            return setupCollectionViewCellFromNib(dataSource: dataSource,
                                                  collectionView: collectionView, 
                                                  indexPath: indexPath, 
                                                  viewModel: viewModel)
        }
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }
}
