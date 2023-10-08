//
//  LeaguesViewController.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit
import SwiftMessages

class LeaguesViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: LeaguesPresenter!
    var pathURL: String!
    
    // MARK: - Outlet
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"
        presenter = LeaguesPresenter(view: self, pathURL: pathURL)
        presenter.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopNotification()
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
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.isConnectedToInternet() {
            presenter.didSelectRow(index: indexPath.row)
        } else {
            presenter.showAlert()
        }
    }
}


//MARK: - Conform LeaguesProtocol
extension LeaguesViewController: LeaguesProtocol {
   
    func reloadLeaguesTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            leaguesTableView.reloadData()
        }
    }
    
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // Note: IF View has reference to Any Model, Code Smells!
    // Code Smells are a result of poor or misguided programming.
    func navigateToLeagueEventsScreen(pathURL: String, leagueId: Int?) {
        let vc = LeagueViewController(nibName: "LeagueViewController", bundle: nil)
        vc.pathURL = pathURL
        vc.leagueId = leagueId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        show(messageAlert: ConnectivityMessage.alertTitle, message: ConnectivityMessage.alertMessage)
    }
    
}
