//
//  TeamViewController.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import UIKit
import Kingfisher

class TeamViewController: UIViewController {
    
    // MARK: - Variables
    var teamPresenter: TeamPresenter!
    
    var pathURL: String!
    var teamId: Int?

    // MARK: - Outlets
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var playersCollectionView: UICollectionView!
//    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var teamTitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var officialWebsiteView: UIView!
    @IBOutlet weak var officialWebsiteButton: UIButton!
    @IBOutlet weak var stadiumImageView: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamPresenter = TeamPresenter(view: self, pathURL: pathURL, teamId: teamId)
        configureCollectionView()
        teamPresenter.getData()
        
        officialWebsiteView.layer.cornerRadius = 8
        officialWebsiteView.clipsToBounds = true
        officialWebsiteView.dropShadow()
        
        // Set the button title
        officialWebsiteButton.setTitle("Official website ", for: .normal)
        
        // Add a system image to the button
        if let systemImage = UIImage(systemName: "arrow.right.circle.fill") {
            officialWebsiteButton.setImage(systemImage, for: .normal)
            officialWebsiteButton.semanticContentAttribute = .forceRightToLeft
            officialWebsiteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // Adjust the inset as needed
        }
            // Create the gradient layer
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = stadiumImageView.bounds
            
            // Define the colors
            let whiteColor = UIColor.white.cgColor
            let clearColor = UIColor.clear.cgColor
            
            gradientLayer.colors = [whiteColor, clearColor, whiteColor]
            
            // Define the locations for color stops
            gradientLayer.locations = [0.0, 0.5, 1.0]
            
            // Configure the gradient direction
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            // Add the gradient layer to your view's layer
            stadiumImageView.layer.addSublayer(gradientLayer)

    }


    // MARK: - Actions
    @IBAction func isFavouriteButtonPressed(_ sender: Any) {
        print("button pressed")
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    
    // MARK: - Private Functions
    private func configureCollectionView() {
        playersCollectionView.dataSource = self
        playersCollectionView.delegate = self
        
        let nib = UINib(nibName: String(describing: TeamCell.self), bundle: nil)
        playersCollectionView.register(nib, forCellWithReuseIdentifier: TeamCell.identifier)
    }
    
    private func updateViewContorllerUI() {
        DispatchQueue.main.async { [weak self] in
//            self?.coachNameLabel.text = self?.teamPresenter.getCoachName()
            self?.teamTitleLabel.text = self?.teamPresenter.getTeamName()
            let stringURL: String? = self?.teamPresenter.getTeamLog()
            guard let stringURL = stringURL else { return }
            guard let url = URL(string: stringURL) else { return }
            self?.teamImageView.kf.setImage(with: url)
        }
    }
}

// MARK: - Collection View Data Source
extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(teamPresenter.getTeamsCount())
        return teamPresenter.getTeamsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else { return TeamCell()}
        teamPresenter.configureCell(cell: cell, for: indexPath.row)
        return cell
    }
    
}

// MARK: - Collection View Delegate
extension TeamViewController: UICollectionViewDelegate {
    
}


// MARK: - Collection View Delegate Flow Layout
extension TeamViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 128, height: 128)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // very important note:-
        // don't forget to assign  Collection View Estimate Size = none, from size inspector.
        let width = collectionView.frame.width * 0.96
        let height = collectionView.frame.height * 0.96
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 4)
    }
}


// MARK: - TeamViewController Protocol

extension TeamViewController: TeamViewControllerProtocol {
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
//        activityIndicator.hidesWhenStopped = true // chanaged the value from attribute inspector
        activityIndicator.stopAnimating()
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.playersCollectionView.reloadData()
            self?.updateViewContorllerUI()
        }
    }
    
}
