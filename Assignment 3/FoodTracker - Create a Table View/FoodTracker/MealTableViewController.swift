//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 5/27/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit

class MealTableViewController: UITableViewController {
    // MARK: Properties
    
    var meals = [Meal]()
    var selectedMeal: String = ""
    var filteredMeal = [Meal]()
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the search controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //searchController.searchBar.scopeButtonTitles = ["All", "Breakfast", "Lunch", "Dinner", "Dessert"]
        //tableView.tableHeaderView = searchController.searchBar
        
        
        let carrotCakePic = UIImage(named: "carrotCake")!
        let carrotCake = Meal(name: "Carrot Cake", type: "Dessert", photo: carrotCakePic, rating: 5)!
        let photo = UIImage(named: "pancake")!
        let pancake = Meal(name: "Pancake, Eggs and Bacon", type: "Breakfast", photo: photo, rating: 5)!
        let fruitLoop = UIImage(named: "fruitLoop")!
        let cereal = Meal(name: "Fruit Loop Cereal", type: "Breakfast", photo: fruitLoop, rating: 5)!
        let oats = UIImage(named: "oatmeal")!
        let oatmeal = Meal(name: "Oatmeal", type: "Breakfast", photo: oats, rating: 5)!
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Meal(name: "Pasta with Meatballs", type: "Lunch" , photo: photo3, rating: 3)!
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Meal(name: "Chicken and Potatoes", type: "Lunch" , photo: photo2, rating: 5)!
        let sandwich = UIImage(named: "sandwich")!
        let chickenSandwich = Meal(name: "Chicken Sandwich",type: "Lunch" ,  photo: sandwich, rating: 5)!
        let pizzaPic = UIImage(named: "pizza")!
        let pizza = Meal(name: "Pepperoni Pizza", type: "Lunch" , photo: pizzaPic, rating: 5)!
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "Caprese Salad", type: "Dinner" , photo: photo1, rating: 4)!
        let tacosPic = UIImage(named: "tacos")!
        let tacos = Meal(name: "Mexican Tacos", type: "Dinner" , photo: tacosPic, rating: 4)!
        let pastaPic = UIImage(named: "pasta")!
        let pasta = Meal(name: "Pasta with Asparagusm", type: "Dinner" , photo: pastaPic, rating: 4)!
        
      

        // Load the sample data.
        if selectedMeal == "Breakfast"{
                loadSampleBreakfast([pancake, cereal, oatmeal])
        }
        else if selectedMeal == "Lunch"{
                loadSampleLunch([meal3,meal2,chickenSandwich, pizza])
        }
        else if selectedMeal == "Dinner"{
            loadSampleDinner([meal1, tacos, pasta])
        }
        else{
            loadSampleDessert([carrotCake])
        }
    }
    
    func loadSampleDessert(mealsInput: [Meal]){
        meals = mealsInput
    }
    func loadSampleBreakfast(mealsInput: [Meal]){
        meals = mealsInput
    }
    
    func loadSampleLunch(mealsInput: [Meal]){
        meals = mealsInput
    }
    func loadSampleDinner(mealsInput: [Meal]){
        meals = mealsInput
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
            return filteredMeal.count
        }
        return meals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let mealSearch : Meal
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
       
        if searchController.active && searchController.searchBar.text != "" {
            mealSearch = filteredMeal[indexPath.row]
        } else {
            mealSearch = meals[indexPath.row]
        }
        
        
        cell.nameLabel.text = mealSearch.name
        cell.photoImageView.image = mealSearch.photo
        cell.ratingControl.rating = mealSearch.rating
        
        return cell
    }
    func filterContentForSearchText(searchText: String) {
        filteredMeal = meals.filter({( mealX : Meal) -> Bool in
            return mealX.name.lowercaseString.containsString(searchText.lowercaseString)        })

        tableView.reloadData()
    }
}

extension MealTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

