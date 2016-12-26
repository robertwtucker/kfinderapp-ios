/**
 * Copyright (c) 2016 Robert Tucker
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit
import RealmSwift

class MainViewController: UITableViewController, UISearchResultsUpdating {
    private let realm = try! Realm()
    private var foodItems: Results<FoodItem>?
    private var filteredFoodItems: Results<FoodItem>?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureSearchBar()
        foodItems = realm.objects(FoodItem.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableViewController

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Create custom UITableViewCell
        let cellIdentifier = "ItemCell"
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
            }
            return cell
        }()
        
        var foodItem: FoodItem
        if searchController.isActive {
            foodItem = filteredFoodItems![indexPath.row]
        } else {
            foodItem = foodItems![indexPath.row]
        }
        
        cell.textLabel?.text = foodItem.name
        cell.detailTextLabel?.text = "\(foodItem.measure) - \(foodItem.k) mcg"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        guard let foodItems = foodItems else {
            return 0
        }
        
        if searchController.isActive {
            return filteredFoodItems!.count
        }
        return foodItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showDetailViewController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .showDetailViewController:
            if let detailViewController = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                if searchController.isActive {
                    detailViewController.foodItem = filteredFoodItems![indexPath.row]
                } else {
                    detailViewController.foodItem = foodItems![indexPath.row]
                }
            }
        }
    }
    

    //MARK: - UISearchResultsUpdating

    func filterContent(for searchText: String, scope: String = "") {
        filteredFoodItems = realm.objects(FoodItem.self).filter("name CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(for: searchController.searchBar.text!)
    }
    
    //MARK: - UI Support
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.autocapitalizationType = .none
        tableView.tableHeaderView = searchController.searchBar
    }
    
}

//MARK: - Extensions

extension MainViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showDetailViewController
    }
}

extension MainViewController: StoryboardIdentifiable {}


