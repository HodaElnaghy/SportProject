//
//  HomeViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Variables
    var presenter: HomePresenter!
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = []
        presenter = HomePresenter(view: self)
        configureCollectionView()
        navigationItem.backBarButtonItem?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Sports"
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HomeCustomCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCell")
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getSportsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCustomCell", for: indexPath) as? HomeCustomCell else { return UICollectionViewCell() }
        presenter.configureCell(cell: cell, for: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2)-13, height: (collectionView.frame.width/2)-13 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.displaySelectItem(index: indexPath.item)
    }
}


// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func navigateToLeaguesScreen(_ sportPathURL: String){
        let vc = LeaguesViewController(nibName: "LeaguesViewController", bundle: nil)
        vc.pathURL = sportPathURL
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
