//
//  ProductTableViewCellEx.swift
//  SportsStore
//
//  Created by apple on 2016/8/7.
//  Copyright © 2016年 GUO. All rights reserved.
//

import UIKit
protocol ProductTableViewCellExProtocol {
    func stockDidChange(cell: ProductTableViewCellEx,id: Int, value: Int)
}

class ProductTableViewCellEx: UITableViewCell {

    var delegate: ProductTableViewCellExProtocol? = nil
    var productId: Int?
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productStockStepper: UIStepper!
    @IBOutlet var productStockTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func stockChange(sender: AnyObject) {
        
        if delegate != nil {
            var newStockLevel: Int?
            if let stepper = sender as? UIStepper {
                newStockLevel = Int(stepper.value)
            } else if let textField = sender as? UITextField {
                newStockLevel = Int(textField.text!) ?? 0
            }
            productStockStepper.value = Double(newStockLevel!)
            productStockTextField.text = String(newStockLevel!)
            delegate!.stockDidChange(self,id: productId!, value: newStockLevel!)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

