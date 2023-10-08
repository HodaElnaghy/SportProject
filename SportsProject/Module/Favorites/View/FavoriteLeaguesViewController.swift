//
//  FavoriteLeaguesViewController.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import UIKit

class FavoriteLeaguesViewController: UIViewController {

    // MARK: - Variables
    var presenter: FavoritesPresenter!
    
    // MARK: - Outlet
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Leagues"
        presenter = FavoritesPresenter(view: self)
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
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        let nib = UINib(nibName: String(describing: LeaguesCell.self), bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: LeaguesCell.identifier)
    }

}

// MARK: - TableView DataSource
extension FavoriteLeaguesViewController: UITableViewDataSource {
   
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
extension FavoriteLeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.isConnectedToInternet() {
            presenter.didSelectRow(index: indexPath.row)
        } else {
            print("presenter.showAlert()!!!!!")
            presenter.showAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure u want to delete league from list?", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { [weak self] action in
                guard let self = self else { return }
                presenter.removeLeagueFromCoreData(at: indexPath.row)
                presenter.updateTableView(at: indexPath)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            present(alertController, animated: true)
        }
    }
}


//MARK: - Conform LeaguesProtocol
extension FavoriteLeaguesViewController: FavoriteLeaguesProtocol {
  
    func reloadLeaguesTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            favoritesTableView.reloadData()
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
    
    func updateTableView(at indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            favoritesTableView.beginUpdates()
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            favoritesTableView.endUpdates()
        }
    }
}
