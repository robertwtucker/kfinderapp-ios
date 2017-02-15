/**
 * Copyright 2017 Robert Tucker
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import RxSwift
import RxCocoa

class FoodSearchViewController: UIViewController {

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
                let viewController: FoodItemViewController = UIStoryboard.storyboard(.main).instantiateViewController()
                viewController.viewModel = viewModel
                self.show(viewController, sender: nil)
            })
            .addDisposableTo(bag)
    }

}


//MARK: - UITableViewDelegate

extension FoodSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


//MARK: - StoryboardIdentifiable

extension FoodSearchViewController: StoryboardIdentifiable { }
