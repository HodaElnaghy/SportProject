//
//  LeagueViewController.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit
import Lottie

class LeagueEventsViewController: UIViewController {
    
    // MARK: - Variables
    private var animationView: LottieAnimationView?
    private var presenter: LeagueEventsPresenter!
    var model: CustomSportModel?
    var isFavourite: Bool?
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        presenter = LeagueEventsPresenter(view: self, model: model)
//        presenter.configConnectivity() // configuer Connectivity
        
        // Presenter fetch data
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.configConnectivity()
        
        if presenter.isFavorite() {
            isFavourite = true // set image "heart.fill"
            print("viewWillAppear: \(presenter.isFavorite())")
        } else {
            isFavourite = false // set image "heart"
            print("viewWillAppear: \(presenter.isFavorite())")
        }
        addFavouriteButton()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        viewWillDisappear(animated)
//        presenter.stopNotification()
//    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(creatCompositionalLayout(), animated:false)

        self.collectionView.register(UINib(nibName: "TeamCustomCell", bundle: nil), forCellWithReuseIdentifier: "TeamCustomCell")
        self.collectionView.register(UINib(nibName: "LeagueCustomCell", bundle: nil), forCellWithReuseIdentifier: "LeagueCustomCell")
        self.collectionView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCell")
        self.collectionView.register( SectionHeader.self, forSupplementaryViewOfKind: LeagueEventsViewController.sectionHeaderElementKind, withReuseIdentifier: SectionHeader.reuseIdentifier)
    }
    
}

// MARK: - Compostional Layout
extension LeagueEventsViewController {
    
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            
            // MARK: - Horizental Cell
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(380), heightDimension: .absolute(200))
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: LeagueEventsViewController.sectionHeaderElementKind, alignment: .top)
            
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
extension LeagueEventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if presenter.getAllTeamsCount() < 1 {
            return 2
        }
        return 3
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
            return setupCellForSection(indexPath: indexPath, identifier: CellIdentifier.LeagueCustomCell, customCell: LeagueCustomCell(), emptyCellText: "No upcoming events available")
        case 1:
            return setupCellForSection(indexPath: indexPath, identifier: CellIdentifier.LeagueCustomCell, customCell: LeagueCustomCell(), emptyCellText: "No latest events available")
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.TeamCustomCell, for: indexPath) as? TeamCustomCell else { return TeamCustomCell() }
            
            presenter.configureTeam(cell: cell, for: indexPath.row)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.TeamCustomCell, for: indexPath) as? TeamCustomCell else { return TeamCustomCell() }
            
            presenter.configureTeam(cell: cell, for: indexPath.row)
            return cell
        }
    }
    private func setupCellForSection(indexPath: IndexPath, identifier: String, customCell: UICollectionViewCell, emptyCellText: String) -> UICollectionViewCell {
            if (presenter.getLatestResultsCount() != 0) {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? LeagueCustomCell else { return customCell }
                if indexPath.section == 0 {
                    presenter.configureUpcomingEvents(cell: cell, for: indexPath.row)
                } else if indexPath.section == 1 {
                    presenter.configurLatestResults(cell: cell, for: indexPath.row)
                }
                cell.isHidden = false
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.EmptyCell, for: indexPath) as? EmptyCell
                else { return EmptyCell() }
                cell.emptyCellLabel.text = emptyCellText
                cell.isHidden = false
                return cell
            }
        }

    }

// MARK: - DatSource Objective-C ?? Ask Hoda
extension LeagueEventsViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50) // Adjust the height as needed
    }
    
    // Provide the view for the section header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderArray: [String] = ["Upcoming Events", "Latest Events", "Teams"]
        if kind == LeagueEventsViewController.sectionHeaderElementKind {
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
extension LeagueEventsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

// TODO: - Ask Hoda!!
extension LeagueEventsViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
}

//MARK: - Conform LeaguesProtocol
extension LeagueEventsViewController: LeagueEventsView {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            collectionView.reloadData()
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
        let vc = TeamViewController(nibName: VCIdentifier.TeamViewController, bundle: nil)
         vc.pathURL = pathURL
         vc.teamId = teamId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        show(messageAlert: ConnectivityMessage.alertTitle, message: ConnectivityMessage.alertMessage)
    }
    func showAlertNotAllowedToNavigate() {
            show(messageAlert: NavigationMessage.alertTitle, message: NavigationMessage.alertMessage)
        }
}


// MARK: - Save League in CoreData
extension LeagueEventsViewController {
    private func addFavouriteButton() {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartButton.tintColor = UIColor.red
        heartButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)

        if isFavourite ?? false{
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
        let leagueId = model?.leagueKey
        let pathURL = model?.sport.rawValue
        let leagueName = details.leagueName
        let leagueLogo = details.leagueLogo
        
        downloadImage(by: leagueLogo) { image in
            guard let image = image else { return }
            //data = image.jpegData(compressionQuality: 0.5)
            data = image.pngData()
        }

        let leagueModelDB = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo, leagueLogoImage: data)
        presenter.insertLeague(leagueModelDB)
    }
    
    private func downloadImage(by stringURL: String?, completion: @escaping(UIImage?) -> Void) {
        UIImageView().downloadImageFrom(stringURL)
    }
}
