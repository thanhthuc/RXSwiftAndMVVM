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

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfPhotos>!
    var searchDataSource: RxCollectionViewSectionedReloadDataSource<SectionOfPhotos>! 
    
    let searchContentController = UITableViewController()
    var searchController: UISearchController!
    
    let disposedBag = DisposeBag()
    
    var viewModel: PhotosViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = PhotosViewModel()

        initDataSource()
        initBindingToCollectionView()
        searchController = UISearchController(searchResultsController: searchContentController)
        
        bindingButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBindingToCollectionView() {
//        collectionView
//            .rx
//            .setDataSource(self.dataSource)
//            .disposed(by: disposedBag)
        viewModel
            .photos
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView
                .rx
                .items(dataSource: self.dataSource))
            .disposed(by: disposedBag)
    }
    
    func initDataSource() {
        self.dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPhotos>(
            configureCell: { 
                sectionedDataSource, collectionView, indexPath, element in 
                return BindableCellFactory<PhotoCollectionViewCell, Photo>.setupCollectionViewCellFromNib(
                    dataSource: sectionedDataSource, 
                    collectionView: collectionView, 
                    indexPath: indexPath, 
                    viewModel: element)
        })
    }
    
    func bindingButton() {
        searchButton
            .rx
            .tap
            .subscribe { [unowned self] _ in
            self.present(self.searchController, animated: true, completion: nil)
        }
            .disposed(by: disposedBag)
        
        filterButton
            .rx
            .tap
            .subscribe { [unowned self] _ in
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let filterNavVC = sb.instantiateViewController(withIdentifier: "FilterViewControllerNav")
            self.present(filterNavVC, animated: true, completion: nil)
        }
            .disposed(by: disposedBag)
    }
    
}


