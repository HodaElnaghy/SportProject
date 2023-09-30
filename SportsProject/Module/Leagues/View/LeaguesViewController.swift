//
//  LeaguesViewController.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    // MARK: - Variables
    private var presenter: LeaguesPresenter!

    // MARK: - Outlet
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"
        
        presenter = LeaguesPresenter(view: self)
        configureTableView()
        presenter.getData()
    }

    //MARK: - Configure TableView
    private func configureTableView() {
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        let nib = UINib(nibName: String(describing: LeaguesCell.self), bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: LeaguesCell.identifier)
    }


}

// MARK: - TableView DataSource
extension LeaguesViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLeaguesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesCell.identifier, for: indexPath) as? LeaguesCell else {  return LeaguesCell() }
        presenter.configureCell(cell: cell, for: indexPath.row)
        return cell
    }
}

//MARK: - TableView Delegate
extension LeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(index: indexPath.row)
    }

}


//MARK: - View Controller Extension

extension LeaguesViewController: LeaguesProtocol {
   
    func reloadLeaguesTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.leaguesTableView.reloadData()
        }
    }
    
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // Note: View has reference to LeaguesModel, Code Smells!
    // Code Smells are a result of poor or misguided programming.
    func navigateToLeagueDetailsScreen(league: LeaguesModel) {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


