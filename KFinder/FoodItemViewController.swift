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

class FoodItemViewController: UIViewController {

    //MARK: Properties

    var viewModel: FoodItemViewModel?
    fileprivate let disposeBag = DisposeBag()

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
        guard let vm = viewModel else { return }
        
        vm.title
            .bindTo(titleLabel.rx.text)
            .disposed(by: disposeBag)
        vm.name
            .bindTo(nameLabel.rx.text)
            .disposed(by: disposeBag)
        vm.measure
            .bindTo(servingSizeLabel.rx.text)
            .disposed(by: disposeBag)
        vm.formattedWeight
            .bindTo(weightAmountLabel.rx.text)
            .disposed(by: disposeBag)
        vm.k
            .bindTo(kAmountLabel.rx.text)
            .disposed(by: disposeBag)
    }

}


//MARK: - StoryboardIdentifiable

extension FoodItemViewController: StoryboardIdentifiable { }
