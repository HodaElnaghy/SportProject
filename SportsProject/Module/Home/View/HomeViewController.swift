//
//  HomeViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
    let sportArray: [HomeSportsModel] = [HomeSportsModel(sportId: 0, sportsImage: "soccer", sportName: "Soccer"),
                                         HomeSportsModel(sportId: 1, sportsImage: "basketBall", sportName: "BasketBall"),
                                         HomeSportsModel(sportId: 2, sportsImage: "cricket", sportName: "Cricket"),
                                         HomeSportsModel(sportId: 3, sportsImage: "tennis", sportName: "Tennis")
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = []
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HomeCustomCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Sports"
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sportArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCustomCell", for: indexPath) as? HomeCustomCell
        let item = sportArray[indexPath.row]
        cell?.sportImage.image = UIImage(named: item.sportsImage)
        cell?.sportName.text = item.sportName
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2)-13, height: (collectionView.frame.width/2)-13 )
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
}
