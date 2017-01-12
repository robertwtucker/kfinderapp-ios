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

private enum Item {
    case About
    case Account
}

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configure()
        print("SetingsVC loaded")
    }

    
    //MARK: Configuration
    
    func configure() {
        tableView.tableFooterView = UIView()
        navigationItem.title = "Settings"
    }
}


//MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SettingsCell"
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            return cell
        }()
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Account"
            cell.detailTextLabel?.text = ">"
            break
        case 1:
            cell.textLabel?.text = "About"
            cell.detailTextLabel?.text = ">"
            break
        default:
            break
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


//MARK: - StoryboardIdentifiable

extension SettingsViewController: StoryboardIdentifiable { }
