//
//  PeopleController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    let apiClient = APIClient()
    var peopleTableViewModel: PeopleTableViewModel?
    var loadingScreenView = LoadingScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreen()
        setupAPIClientWithParameters(NetworkingConstants.BASE_URL, NetworkingConstants.PEOPLE_URL)
        setupViewModel()
        setupTableView()
        setupTableViewBinding()
    }
    
    /**
     Sets a loading screen as subview of the tableView while the data is being fetched.
     */
    private func setLoadingScreen() {
        loadingScreenView.setLoadingScreen((navigationController?.navigationBar.frame.height)!, tableView)
    }
    
    /**
     Hides the loading screen when the data is fetched.
     */
    private func removeLoadingScreen() {
        loadingScreenView.removeLoadingScreen()
    }
    
    /**
     Shows the loading screen when more data is being fetched.
     */
    private func showLoadingScreen() {
        loadingScreenView.showLoadingScreen()
    }
    
    /**
     Sets up the API Client with custom parameters that will be used for network requests.
     */
    private func setupAPIClientWithParameters(_ baseURL: String, _ path: String) {
        apiClient.setResourceURLParameters(baseURL, path)
    }
    
    /**
     Sets up the API Client with custom parameters that will be used for network requests.
     */
    private func setupAPIClientWithFullURL(_ fullURL: String) {
        apiClient.setResourceFullURL(fullURL)
    }
    
    /**
     Sets up the view model passing as a parameter a closure for the API requests.
     */
    private func setupViewModel() {
        peopleTableViewModel = PeopleTableViewModel(request: apiClient.getPeopleResponse())
    }
    
    /**
     Sets up the table view.
     */
    private func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    /**
     Sets up the table view data by binding itself to the ViewModel peopleList observable.
     */
    private func setupTableViewBinding() {
        
        peopleTableViewModel?.outputs.peopleList?
            .drive(tableView.rx.items(cellIdentifier: UIConstants.PERSON_CELL_IDENTIFIER, cellType: PeopleTableViewCell.self)) { (row, element, cell) in
                
                self.customizePersonCell(cell, row, element.name, element.gender.rawValue.capitalizingFirstLetter())
                self.removeLoadingScreen()

            }
            .disposed(by: disposeBag)
        
    }
    
    /**
     Customize each PersonCell with the corresponding data and style
     - Parameter cell: The cell that will be modified
     - Parameter row: The cell row number
     - Parameter personName: The person name that will go on the cell personNameLabel
     - Parameter personGender: The person gender that will go on the cell personGenderLabel
     */
    private func customizePersonCell(_ cell: PeopleTableViewCell, _ row: Int, _ personName: String, _ personGender: String) {
        
        if row % 2 == 0 {
            cell.backgroundColor = UIConstants.EVEN_CELL_COLOR
        } else {
            cell.backgroundColor = UIConstants.ODD_CELL_COLOR
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.personNameLabel.text = personName
        cell.personGenderLabel.text = personGender
        
    }
    
    /**
     Detects if the user has scrolled all the way down and triggers a ViewModel event to fetch more data.
     */
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rowCount = getAllRowCount()
        
        guard (rowCount == indexPath.row && rowCount < NetworkingConstants.PEOPLE_MAX_PAGE) else { return }
        
        showLoadingScreen()
        peopleTableViewModel?.inputs.nextPageTrigger.accept(())
        
    }
    
    /**
     Gets the number of rows in the table view.
     - Returns: The number of rows in the table view.
     */
    func getAllRowCount() -> Int{
        var rowCount = 0
        for index in 0...self.tableView.numberOfSections-1{
            rowCount += self.tableView.numberOfRows(inSection: index)
        }
        return rowCount-1
    }

    
}
