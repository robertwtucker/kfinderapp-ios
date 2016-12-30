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
        tableView.rx.setDelegate(self).addDisposableTo(bag)
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
        
        tableView.rx.modelSelected(FoodItemCellViewModel.self)
            .bindTo(vm.selectedModel)
            .addDisposableTo(bag)
        
        vm.navigationBarTitle
            .bindTo(navigationItem.rx.title)
            .addDisposableTo(bag)
        
        vm.searchResults
            .bindTo(tableView.rx.items(cellIdentifier: "ItemCell")) { (index, model: FoodItemCellViewModel, cell) in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = model.description                
            }
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


//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


//MARK: - StoryboardIdentifiable

extension MainViewController: StoryboardIdentifiable { }
