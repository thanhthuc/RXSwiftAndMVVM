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
        let cell = tableView.cellForRow(at: indexPath) as! SelectTableViewCell
        
        guard let boolValue = dictSelected[indexPath] else {
            dictSelected[indexPath] = true
            cell.selectImageView.image = UIImage(named: "checked")
            return
        }
        
        switch indexPath.section {
        case 0:
            let numOfRow = tableView.numberOfRows(inSection: indexPath.section)
            
            if indexPath.row == 0 {
                for i in 1..<numOfRow {
                    if i != indexPath.row {
                        let indexPath = IndexPath(row: i, section: 0)
                        if !boolValue {
                            dictSelected[IndexPath(row: 0, section: 0)] = true
                        	dictSelected[indexPath] = false
                        }
                    }
                }
                
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
            	let indexPath = IndexPath(row: 0, section: 0)    
                let cell = tableView.cellForRow(at: indexPath) as! SelectTableViewCell
                cell.selectImageView.image = UIImage(named: "unchecked") 
                dictSelected[indexPath] = !dictSelected[indexPath]!
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            }
            
            
        case 1:
            if indexPath.row == 0 {
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
                
            }
        default:
            if indexPath.row == 0 {
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
                
            }
        }
        
        dictSelected[indexPath] = !boolValue
        cell.selectImageView.image = dictSelected[indexPath]! ? UIImage(named: "checked") : UIImage(named: "unchecked")
        
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
        return 8
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
