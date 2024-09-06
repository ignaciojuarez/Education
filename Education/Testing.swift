//
//  Testing.swift
//  Education
//
//  Created by Ignacio Juarez on 9/5/24.
//

import Foundation
import UIKit

public struct Testing {
    //var target = 7
    //var numbersArray = [1,2,3,4,5,6,7,8]
    
    public func twoSum(numbers: [Int], target: Int) -> [Int] {
        var dict: [Int:Int] = [:] // [lookingValue:index of the one looking]
        // [6:0]
        for (index, val) in numbers.enumerated() {
            
            if let lookingIndex = dict[val] {
                return [index, lookingIndex]
            }
            
            dict[target - val] = index
        }
        
        return []
    }
}

//class CustomTableViewCell: UITableViewCell {
//    @IBOutlet weak var itemLabel: UILabel!
//    @IBOutlet weak var iconImageView: UIImageView!
//}
//
//class ViewController: UITableViewController {
//    var items: [Item] = []  // Assume 'Item' is a struct with properties 'name' and 'iconName'
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
//        let item = items[indexPath.row]
//        cell.itemLabel.text = item.name
//        cell.iconImageView.image = UIImage(named: item.iconName)
//        return cell
//    }
//}

