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
import RxCocoa
import RxSwift

private enum Item {
    case About
    case Account
}

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    var viewModel: SettingsViewModel?
    private let bag = DisposeBag()
    
    @IBOutlet weak var acknowledgementsButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        print("SetingsVC loaded")
    }

    
    //MARK: Configuration
    
    func configure() {
        guard let vm = viewModel else {
            print("ViewModel not set!")
            return
        }
        
        vm.navigationBarTitle
            .bindTo(navigationItem.rx.title)
            .addDisposableTo(bag)
        
        vm.applicationVersion
            .bindTo(versionLabel.rx.text)
            .addDisposableTo(bag)
    }
    
    @IBAction func didTapAcknowledgements(_ sender: Any) {
        guard let url = Bundle.main.url(forResource: "acknowledgements", withExtension: "html") else {
            print("HTML not found!")
            return
        }

        let htmlHeader = "<html>\n<head>\n<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n<link href=\"default.css\" rel=\"stylesheet\" type=\"text/css\"/>\n</head>\n<body>\n"
        let htmlFooter = "</body>\n</html>"
        
        do {
            let htmlBody = try String.init(contentsOf: url)
            let viewController: WebViewController = UIStoryboard.storyboard(.settings).instantiateViewController()
            viewController.html = String.init(format: "%@%@%@", htmlHeader, htmlBody, htmlFooter)
            show(viewController, sender: nil)
        } catch {
            print("Unable to load HTML: \(error)")
        }
    }
}


//MARK: - StoryboardIdentifiable

extension SettingsViewController: StoryboardIdentifiable { }
