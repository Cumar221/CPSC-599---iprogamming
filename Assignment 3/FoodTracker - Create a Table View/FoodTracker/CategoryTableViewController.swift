//
//  CategoryTableViewController.swift
//  FoodTracker
//
//  Created by maya2016 on 2016-10-02.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit


class CategoryTableViewController: UITableViewController {
    var categories = [myCategoryClass]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleCetegories()
    }
    
    func loadSampleCetegories(){
        let cat1 = myCategoryClass(name: "Breakfast")
        let cat2 = myCategoryClass(name: "Lunch")
        let cat3 = myCategoryClass(name: "Dinner")
        let cat4 = myCategoryClass(name: "Dessert")
        categories.append(cat1!)
        categories.append(cat2!)
        categories.append(cat3!)
        categories.append(cat4!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CategoryTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryTableViewCell
        print(categories[indexPath.row].name)
        cell.catLabel.text = categories[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC : MealTableViewController = segue.destinationViewController as! MealTableViewController
        let indexpath = self.tableView.indexPathForSelectedRow
        let selectedCategory = self.categories[indexpath!.row]
        
        secondVC.selectedMeal = selectedCategory.name

    }
    
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
