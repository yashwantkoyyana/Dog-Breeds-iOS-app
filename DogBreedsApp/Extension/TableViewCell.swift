//
//  TableViewCell.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

extension UITableViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
    class func registerAsNibWith(tableView: UITableView) {
        let cellName = String(describing: self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }

    class func registerAsCellClassWith(tableView: UITableView) {
        let cellName = String(describing: self)
        tableView.register(self.self, forCellReuseIdentifier: cellName)
    }
}

extension UITableViewHeaderFooterView {
    class func registerHeaderFooterAsNibWith(tableView: UITableView) {
        let cellName = String(describing: self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forHeaderFooterViewReuseIdentifier: cellName)
    }
}
