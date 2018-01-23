//
//  ViewController.swift
//  tableViewSelection
//
//  Created by Thuc on 1/18/18.
//  Copyright © 2018 Thuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dictSelected: [IndexPath: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var boolValue = false
        if let value = dictSelected[indexPath] {
            boolValue = value
        } else {
            dictSelected[indexPath] = false
            boolValue = dictSelected[indexPath]!
        }
        
        let numOfRow = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == 0 {
            let boolAtFirst = !boolValue
            dictSelected[IndexPath(row: 0, section: indexPath.section)] = boolAtFirst
            for i in 1..<numOfRow {
                if i != indexPath.row {
                    let indexPath = IndexPath(row: i, section: indexPath.section)
                    if !boolAtFirst {
                        dictSelected[IndexPath(row: 0, section: indexPath.section)] = false
                        dictSelected[indexPath] = false
                    } else {
                        dictSelected[IndexPath(row: 0, section: indexPath.section)] = true
                        dictSelected[indexPath] = true
                    }
                }
            }
        } else {
            let indexPathAt0 = IndexPath(row: 0, section: indexPath.section)    
            dictSelected[indexPathAt0] = false
            dictSelected[indexPath] = !dictSelected[indexPath]!
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let arr = ["Section 1", "Section 2", "Section 3"]
        return arr[section]
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectTableViewCell
        guard let boolValue = dictSelected[indexPath] else { 
            cell.selectImageView.image = UIImage(named: "unchecked")
            return cell 
        }
        cell.selectImageView.image = boolValue ? UIImage(named: "checked") :  UIImage(named: "unchecked")
        return cell
    }
}
