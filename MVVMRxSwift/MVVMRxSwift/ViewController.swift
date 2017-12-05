//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by iOS Developer on 12/5/17.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "London", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source
    var showCities: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var disposedBag = DisposeBag() 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showCities = allCities
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(
            onNext: { (string) in
                print(string)
                self.showCities = self.allCities.filter({ (valueString) -> Bool in
                    return valueString.hasPrefix(string)
                })
                self.tableView.reloadData()
        }, onError: { (error) in
            print(error)
        }, onCompleted: { 
            print("completed")
        }) { 
            print("disposed")
            
            }.disposed(by: disposedBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = showCities[indexPath.row]
        return cell
    }
}



