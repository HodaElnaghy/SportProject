//
//  LeagueViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit
import Lottie


class LeagueViewController: UIViewController {
    
    // MARK: - Variables
    private var animationView: LottieAnimationView?
    private var presenter: LeagueEventsPresenter!
    var pathURL: String!
    var leagueId: Int?
    var flag: Bool?
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeagueEventsPresenter(view: self, pathURL: pathURL, leagueId: leagueId)
//        presenter.configConnectivity() // configuer Connectivity
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(creatCompositionalLayout(), animated:false)

        self.collectionView.register(UINib(nibName: "TeamCustomCell", bundle: nil), forCellWithReuseIdentifier: "TeamCustomCell")
        self.collectionView.register(UINib(nibName: "LeagueCustomCell", bundle: nil), forCellWithReuseIdentifier: "LeagueCustomCell")
        self.collectionView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCell")
        self.collectionView.register( SectionHeader.self, forSupplementaryViewOfKind: LeagueViewController.sectionHeaderElementKind, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        // Presenter fetch data
        presenter.viewDidLoad()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //presenter.configConnectivity()
        
        if presenter.isFavorite() {
            flag = true // set image "heart.fill"
            print("viewWillAppear: \(presenter.isFavorite())")
            
        } else {
            flag = false // set image "heart"
            print("viewWillAppear: \(presenter.isFavorite())")
        }
        
        addFavouriteButton()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        viewWillDisappear(animated)
//        presenter.stopNotification()
//    }
    
    
}

// MARK: - Compostional Layout
extension LeagueViewController {
    
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            
            // MARK: - Horizental Cell
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(380), heightDimension: .absolute(200))
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
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
            
            // MARK: - Vertical Cell
            let itemSize1 = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.contentSize.width - 10), heightDimension: .fractionalHeight(1))
            
            let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
            
            let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item1])
            
            group1.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let section1 = NSCollectionLayoutSection (group: group1)
//            section1.orthogonalScrollingBehavior = .continuous
            section1.boundarySupplementaryItems = [sectionHeader]
            
            // MARK: - Last Section
            let groupSize1 = NSCollectionLayoutSize(
                widthDimension: .absolute(150), heightDimension: .absolute(150))
            let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
            
            let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1, subitems: [item2])
            group2.contentInsets = NSDirectionalEdgeInsets (top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let section2 = NSCollectionLayoutSection(group: group2)
            section2.boundarySupplementaryItems = [sectionHeader]
            section2.orthogonalScrollingBehavior = .continuous
            
            return index == 0 ? section0 : (index == 1 ? section1 : section2)
        }
        return layout
    }
}

// MARK: - Data Source
extension LeagueViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.getUpcomingEventsCount() == 0 ? 1 :  presenter.getUpcomingEventsCount()
        case 1:
            return presenter.getLatestResultsCount() == 0 ? 1 :  presenter.getLatestResultsCount()
        case 2:
            print("cell count: \(presenter.getAllTeamsCount())")
            return presenter.getAllTeamsCount()
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            if (presenter.getLatestResultsCount() != 0) {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCustomCell", for: indexPath) as? LeagueCustomCell else { return LeagueCustomCell() }
                presenter.configureUpcomingEvents(cell: cell, for: indexPath.row)
                cell.isHidden = false
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as? EmptyCell
                else { return LeagueCustomCell() }
                cell.emptyCellLabel.text = "No upcoming events available"
                cell.isHidden = false
                return cell
            }
            
        case 1:
            if presenter.getLatestResultsCount() != 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCustomCell", for: indexPath) as? LeagueCustomCell else { return LeagueCustomCell() }
                
                presenter.configurLatestResults(cell: cell, for: indexPath.row)
                cell.isHidden = false
                
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as? EmptyCell
                else { return LeagueCustomCell() }
                cell.emptyCellLabel.text = "No latest events available"
                cell.isHidden = false
                return cell
            }
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCustomCell", for: indexPath) as? TeamCustomCell else { return TeamCustomCell() }
            
            presenter.configureTeam(cell: cell, for: indexPath.row)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCustomCell", for: indexPath) as? TeamCustomCell else { return TeamCustomCell() }
            
            presenter.configureTeam(cell: cell, for: indexPath.row)
            return cell
        }
    }
}

// MARK: - DatSource Objective-C ?? Ask Hoda
extension LeagueViewController {
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

// MARK: - Delegate & Delegate Flow Layout
extension LeagueViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            print(indexPath)
//            print("isConnected ggg: \(presenter.isConnectedToInternet())")
//            if presenter.isConnectedToInternet() {
//                presenter.didSelectRow(index: indexPath.item)
//            } else {
//                presenter.showAlert()
//            }
            presenter.didSelectRow(index: indexPath.item)
        default:
            print("Not allowed to select")
        }
    }
}

extension LeagueViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
}

//MARK: - Conform LeaguesProtocol

extension LeagueViewController: LeagueEventsView {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func reloadSection(At index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let indexSet = IndexSet(integer: index)
            collectionView.reloadSections(indexSet)
        }
    }
    
    func navigateToTeamScreen(pathURL: String, teamId: Int?) {
        let vc = TeamViewController(nibName: "TeamViewController", bundle: nil)
         vc.pathURL = pathURL
         vc.teamId = teamId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showAlert() {
        show(messageAlert: ConnectivityMessage.alertTitle, message: ConnectivityMessage.alertMessage)
    }

}


// MARK: - Save League in CoreData
extension LeagueViewController {
    private func addFavouriteButton() {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartButton.tintColor = UIColor.red
        heartButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)

        if flag ?? false{
            heartButton.isSelected = true
        }

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        navigationItem.rightBarButtonItem = heartBarButtonItem
    }
    
    func playAnimation() {
        animationView = .init(name: "Favorite")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        // 4. Set animation loop mode
        animationView!.loopMode = .playOnce
        view.addSubview(animationView!)
        // 6. Play animation
        animationView?.play { [weak self] _ in
            self?.animationView?.removeFromSuperview()
        }
    }

    @objc func toggleFavourite(sender: UIButton) {
        // Toggle the selected state to change the button's image
        sender.isSelected.toggle()
        if sender.isSelected {
            // add to coreData
            addToCoreData()
            playAnimation()
        } else {
            // remove from CoreData
            removeFromCoreData()
        }
    }
    
    func addToCoreData() {
        print("Added to core data")
        if !presenter.isFavorite() {
            saveLeagueIntoCoreData()
        }
    }

    func removeFromCoreData() {
        print("remove from core data")
        presenter.removeLeague()
    }
 
    func saveLeagueIntoCoreData() {
        var data: Data? = Data()
        let details = presenter.getLeagueDetails()

        let leagueId = leagueId
        let pathURL = pathURL
        let leagueName = details.leagueName
        let leagueLogo = details.leagueLogo
        
        downloadImageFrom(leagueLogo) { image in
            guard let image = image else { return }
            //data = image.jpegData(compressionQuality: 0.5)
            data = image.pngData()
        }

        let leagueModelDB = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo, leagueLogoImage: data)
        presenter.insertLeague(leagueModelDB)
    }
    
    private func downloadImageFrom(_ stringURL: String?, completion: @escaping(UIImage?) -> Void) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }

        UIImageView().kf.setImage(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let imageRes):
                completion(imageRes.image)
            case .failure(_):
                completion(UIImage(named: "heart.fill"))
            }
        }
    }
}
