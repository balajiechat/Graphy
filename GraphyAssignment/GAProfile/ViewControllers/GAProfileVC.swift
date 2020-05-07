//
//  GAProfileVC.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

enum GAProfileConstants: String {
    case profileImageCellIdentifier = "GAProfileImageCell"
    case profileBasicCellIdentifier = "GAProfileBasicCell"
}

protocol GAProfileViewProtocol: class {

    var presenter: GAProfilePresenterProtocol?  { get set }

    func updateUI(models: [GAProfile])

}

class GAProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

	var presenter: GAProfilePresenterProtocol?
    private var models = [GAProfile]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.getUserProfileData()
    }

}


extension GAProfileVC: GAProfileViewProtocol {

    func updateUI(models: [GAProfile]) {
        DispatchQueue.main.async {
            self.models = models
            self.tableView.reloadData()
        }
    }

}

extension GAProfileVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.models[indexPath.row]
        if model.section == .photo {
            let cell = tableView.dequeueReusableCell(withIdentifier: GAProfileConstants.profileImageCellIdentifier.rawValue, for: indexPath) as! GAProfileImageCell
            cell.model = model

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GAProfileConstants.profileBasicCellIdentifier.rawValue, for: indexPath)
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = model.subTitle

            return cell
        }
    }

}
