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

class DetailViewController: UIViewController {

    //MARK: Properties

    var viewModel: FoodItemViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var weightAmountLabel: UILabel!
    @IBOutlet weak var kAmountLabel: UILabel!


    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }


    //MARK: Configuration

    func configure() {
        guard let vm = viewModel else {
            print("ViewModel not set!")
            return
        }

        titleLabel.text = vm.title
        nameLabel.text = vm.name
        servingSizeLabel.text = vm.measure
        weightAmountLabel.text = vm.weight
        kAmountLabel.text = vm.k
    }

}


//MARK: - StoryboardIdentifiable

extension DetailViewController: StoryboardIdentifiable { }
