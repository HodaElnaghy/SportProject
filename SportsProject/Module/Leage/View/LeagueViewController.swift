//
//  LeagueViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class LeagueViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "LeagueCustomCell", bundle: nil), forCellWithReuseIdentifier: "LeagueCustomCell")
        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewCompositionalLayout { index, environment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0)
            
            let section0 = NSCollectionLayoutSection(group: group)
            section0.orthogonalScrollingBehavior = .continuous
            
            let itemSize1 = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.contentSize.width), heightDimension: .fractionalHeight(0.8))
            
            
            let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
            
            let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item1])
            
            group1.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0)
            let section1 = NSCollectionLayoutSection (group: group1)
            let section2 = NSCollectionLayoutSection(group: group)
            
            section2.orthogonalScrollingBehavior = .continuous
            return index == 0 ? section0 : (index == 1 ? section1 : section2)
            
            
        }
        collectionView.setCollectionViewLayout(layout, animated:false )
    }
        
        



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCustomCell", for: indexPath) as? LeagueCustomCell
        
        // Configure the cell
        
        cell?.teamOneImage.image = UIImage(named: "1")
        return cell ?? UICollectionViewCell()
    }
}
