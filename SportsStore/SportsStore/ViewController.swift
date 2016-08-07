//
//  ViewController.swift
//  SportsStore
//
//  Created by apple on 2016/8/4.
//  Copyright © 2016年 GUO. All rights reserved.
//

import UIKit
class ProductTableViewCell: UITableViewCell {
    var productId: Int!
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productStockStepper: UIStepper!
    
    @IBOutlet var productStockTextField: UITextField!

}
class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var totalStockLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var products = [
        ("桌子", 20),
        ("椅子", 60),
        ("檯燈", 50),
        ("櫃子", 10)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        showStockTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ProductTableViewCell
//        cell.productId = indexPath.row
//        cell.productNameLabel.text = product.0
//        cell.productStockStepper.value = Double(product.1)
//        cell.productStockTextField.text = String(product.1)
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ProductTableViewCellEx
        cell.productId = indexPath.row
        cell.productNameLabel.text = product.0
        cell.productStockStepper.value = Double(product.1)
        cell.productStockTextField.text = String(product.1)
        cell.delegate = self
        return cell
    }

    @IBAction func stockLevelDidChange(sender: AnyObject) {
 
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableViewCell {
                    if let id = cell.productId {
                        var newStockLevel: Int?
                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value)
                        } else if let textField = sender as? UITextField {
                            newStockLevel = Int(textField.text!) ?? 0
                        }
                        if let level = newStockLevel {
                            products[id].1 = level
                            cell.productStockStepper.value = Double(level)
                            cell.productStockTextField.text = String(level)
                        }
                    }
                    break
                }
            }
            showStockTotal()
        }
        
        
    }
    
    func showStockTotal(){
        let stockTotal = products.reduce(0) {  (total, product) -> Int in
            return total+product.1
        }
        totalStockLabel.text = "共 \(stockTotal) 個商品"
    }

}
extension ViewController: ProductTableViewCellExProtocol {
    func stockDidChange(cell: ProductTableViewCellEx,id: Int, value: Int) {
        products[id].1 = value
        showStockTotal()
    }
}
