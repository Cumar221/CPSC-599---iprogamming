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
    var filterCategory = [myCategoryClass]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the search controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //load up the menu
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
        if searchController.active && searchController.searchBar.text != "" {
            return filterCategory.count
        }
        return categories.count
    }
   // override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categories.count
   // }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryTableViewCell"
        let categorySel : myCategoryClass
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryTableViewCell
       
        if searchController.active && searchController.searchBar.text != "" {
            categorySel = filterCategory[indexPath.row]
        } else {
            categorySel = categories[indexPath.row]
        }
        
        cell.catLabel.text = categorySel.name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC : MealTableViewController = segue.destinationViewController as! MealTableViewController
        let indexpath = self.tableView.indexPathForSelectedRow
        let selectedCategory = self.categories[indexpath!.row]
        
        secondVC.selectedMeal = selectedCategory.name

    }
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filterCategory = categories.filter { categor in
            return categor.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        
        tableView.reloadData()
    }
    
}
extension CategoryTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
