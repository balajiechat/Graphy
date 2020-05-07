//
//  GAHomeVC.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

enum GAHomeConstants: String {
    case homeCellIdentifier = "GAHomeCell"
}

protocol GAHomeViewProtocol: class {

    var presenter: GAHomePresenterProtocol?  { get set }

    func updateUI(models: [GAHomeViewModel]?)

}

class GAHomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!

	var presenter: GAHomePresenterProtocol?
    private var models = [GAHomeViewModel]()

	override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.presenter?.getData()
    }

}

extension GAHomeVC: GAHomeViewProtocol {

    func updateUI(models: [GAHomeViewModel]?) {
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = true
            self.loader.stopAnimating()
            guard let models = models else {
                self.collectionView.isHidden = true
                self.noDataLabel.isHidden = false
                return
            }
            self.models = models
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
        }
    }

}

extension GAHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.animateCell()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAHomeConstants.homeCellIdentifier.rawValue, for: indexPath) as! GAHomeCell
        let model = self.models[indexPath.row]
        cell.model = model

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        self.presenter?.playSelectedVideo(url: model.videoURL)
    }

}
