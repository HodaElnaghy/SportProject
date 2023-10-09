//
//  HomeViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit
import SwiftMessages


class HomeViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: HomePresenter!
    let defaults = UserDefaults.standard
    // TODO: - Save isListView in userDefaults.
    var isListView: Bool?
    // TODO: - Adjust image with Button.
    var toggleButton = UIBarButtonItem()

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "isListView").description.isEmpty {
            isListView = false
        }
        self.navigationItem.leftBarButtonItems = []
        presenter = HomePresenter(view: self)
        
        presenter.viewDidLoad()
        configureCollectionView()
        navigationItem.backBarButtonItem?.isHidden = true
        var image = UIImage(systemName: "square.grid.2x2")
        if defaults.bool(forKey: "isListView") {
            image = UIImage(systemName: "list.bullet")
        }
        
        
        toggleButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(butonTapped(sender:)))
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopNotification()
    }
    
    @objc func butonTapped(sender: UIBarButtonItem) {
        if defaults.bool(forKey: "isListView") {
            toggleButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
            isListView = false
            defaults.set(isListView, forKey: "isListView")
        }else {
            toggleButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
            isListView = true
            defaults.set(isListView, forKey: "isListView")
        }
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        self.collectionView?.reloadData()
    }
    
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CellIdentifier.HomeCustomCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.HomeCustomCell)
    }

}

// MARK: - UICollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getSportsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.HomeCustomCell, for: indexPath) as? HomeCustomCell else { return UICollectionViewCell() }
//        if isListView {
//            presenter.configureCell(cell, for: indexPath.item)
//            return cell
//        } else {
//            presenter.configureCell(cell, for: indexPath.item)
//            return cell
//        }
        presenter.configureCell(cell, for: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presenter.isConnectedToInternet() {
            presenter.didsplaySelectItem(at: indexPath.item)
        } else {
            presenter.showAlert()
        }
    }
}

// MARK: - UICollectionView DelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if defaults.bool(forKey: "isListView") == false {
            return CGSize(width: width - 30, height: ((width - 15)/2)-30)
        } else {
            return CGSize(width: (width - 15)/2, height: (width - 15)/2)
        }
    }
}


// MARK: - HomeView Protocol
extension HomeViewController: HomeViewProtocol {
   
    func navigateToLeaguesScreen(_ sport: SportType){
        let vc = LeaguesViewController(nibName: VCIdentifier.LeaguesViewController, bundle: nil)
        vc.sport = sport
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        show(messageAlert: ConnectivityMessage.alertTitle, message: ConnectivityMessage.alertMessage)
    }
}

