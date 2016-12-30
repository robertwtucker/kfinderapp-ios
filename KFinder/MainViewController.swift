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
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    //MARK: Properties
    
    var viewModel: FoodSearchViewModel?
    fileprivate var dataSource = [FoodItemCellViewModel]()
    private let bag = DisposeBag()
    
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    

    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        configure()
        
    }


    //MARK: Configuration
    
    func configure() {
        guard let vm = viewModel else {
            print("ViewModel not set!")
            return
        }
        
        searchBar.rx.text.orEmpty
            .bindTo(vm.searchText)
            .addDisposableTo(bag)
        
        tableView.rx.itemSelected
            .map { self.dataSource[$0.row].foodItem }
            .bindTo(vm.selectedFoodItem)
            .addDisposableTo(bag)
        
        vm.navigationBarTitle
            .drive(self.navigationItem.rx.title)
            .addDisposableTo(bag)
        
        vm.searchResults
            .drive(onNext: { [weak self] (results: [FoodItemCellViewModel]) in
                guard let `self` = self else { return }
                self.dataSource = results
                self.tableView.reloadData()
            })
            .addDisposableTo(bag)

        vm.selectedFoodItemViewModel
            .subscribe(onNext: { [weak self] viewModel in
                guard let `self` = self else { return }
                let viewController: DetailViewController = UIStoryboard.storyboard(.main).instantiateViewController()
                viewController.viewModel = viewModel
                self.show(viewController, sender: nil)
            })
            .addDisposableTo(bag)
    }
    
}


//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Create custom UITableViewCell
        let cellIdentifier = "ItemCell"
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
            }
            return cell
        }()
        
        cell.textLabel?.text = dataSource[indexPath.row].name
        cell.detailTextLabel?.text = dataSource[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return dataSource.count
    }
}


//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - StoryboardIdentifiable

extension MainViewController: StoryboardIdentifiable { }
