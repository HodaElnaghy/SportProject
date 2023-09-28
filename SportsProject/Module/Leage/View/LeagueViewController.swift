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
        
        self.collectionView.register(UINib(nibName: "TeamCustomCell", bundle: nil), forCellWithReuseIdentifier: "TeamCustomCell")
        self.collectionView.register(UINib(nibName: "LeagueCustomCell", bundle: nil), forCellWithReuseIdentifier: "LeagueCustomCell")
        self.collectionView.register(
          SectionHeader.self,
          forSupplementaryViewOfKind: LeagueViewController.sectionHeaderElementKind,
          withReuseIdentifier: SectionHeader.reuseIdentifier)
        // Do any additional setup after loading the view.
        
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        let layout = UICollectionViewCompositionalLayout { index, environment in
//            let itemSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
             
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//            group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0)
//
//            let section0 = NSCollectionLayoutSection(group: group)
//            section0.orthogonalScrollingBehavior = .continuous
//
           
            // horizental cell
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(380), heightDimension: .absolute(200))
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: LeagueViewController.sectionHeaderElementKind, alignment: .top)
            
            
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.contentSize.width - 20), heightDimension: .fractionalHeight(1))
            
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
            let section0 = NSCollectionLayoutSection(group: group)
                      section0.orthogonalScrollingBehavior = .continuous
            section0.boundarySupplementaryItems = [sectionHeader]

            
            
            
            
            // vertical cell
            
            
            let itemSize1 = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.contentSize.width - 10), heightDimension: .fractionalHeight(1))
            
            
            let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
            
            let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item1])
            
            group1.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
            
            
            
            
            let section1 = NSCollectionLayoutSection (group: group1)
            section1.boundarySupplementaryItems = [sectionHeader]
            
            
            
            //last section
            let groupSize1 = NSCollectionLayoutSize(
                widthDimension: .absolute(150), heightDimension: .absolute(150))
            let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            
            let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
            
            let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1, subitems: [item2])
            
            group2.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
            let section2 = NSCollectionLayoutSection(group: group2)
                      section0.orthogonalScrollingBehavior = .continuous
            
            section2.boundarySupplementaryItems = [sectionHeader]

            
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

extension LeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCustomCell", for: indexPath) as? TeamCustomCell
            return cell ?? UICollectionViewCell()
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCustomCell", for: indexPath) as? LeagueCustomCell
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: 100, height: 50) // Adjust the height as needed
        }
        
        // Provide the view for the section header
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let sectionHeaderArray: [String] = ["Upcoming Events", "Latest Events", "Teams"]
            if kind == LeagueViewController.sectionHeaderElementKind {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
                
                // Customize the header view, for example, setting the title
                headerView.label.text = sectionHeaderArray[indexPath.section]
                
                return headerView
            }
            
            // Return an empty view for other kinds (e.g., footer)
            return UICollectionReusableView()
        }
    }

extension LeagueViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
}
