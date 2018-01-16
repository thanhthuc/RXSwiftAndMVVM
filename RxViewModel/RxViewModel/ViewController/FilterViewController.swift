//
//  ViewController.swift
//  RxViewModel
//
//  Created by Thuc on 1/13/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionOfPhotos>!
    var searchDataSource: RxTableViewSectionedReloadDataSource<SectionOfPhotos>! 
    var viewModel: PhotosViewModelType!
    
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = PhotosViewModel()
        initDataSource()
        initBindingToTableView()
        initBindingButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBindingToTableView() {
        
        
    }
    
    func initBindingButton() {
        doneButton
            .rx
            .tap
			.subscribe {[unowned self] _ in
                self.navigationController?.dismiss(animated: true, completion: nil)
        }
            .disposed(by: disposedBag)
    }
    
    func initDataSource() {
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionOfPhotos>(
            configureCell: { 
                dataSource, tableView, indexPath, element  in 
                
                return BindableCellFactory<PhotoFilterTableViewCell, Photo>
                    .setupTableViewCellFromNib(dataSource: dataSource, 
                                          tableView: tableView, 
                                          indexPath: indexPath, 
                                          viewModel: element)
        })
        
        self.searchDataSource = RxTableViewSectionedReloadDataSource<SectionOfPhotos>(
            configureCell: { 
                dataSource, tableView, indexPath, element  in 
                
                return BindableCellFactory<PhotoFilterTableViewCell, Photo>
                    .setupTableViewCellFromNib(dataSource: dataSource, 
                                          tableView: tableView, 
                                          indexPath: indexPath, 
                                          viewModel: element)
        })
    }
    
}



