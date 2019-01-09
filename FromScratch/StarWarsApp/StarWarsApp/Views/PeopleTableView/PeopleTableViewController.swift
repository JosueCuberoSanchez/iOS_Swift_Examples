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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupTableViewBinding()
    }
    
    /**
     Sets up the view model passing as a parameter a closure for the API requests.
     */
    private func setupViewModel() {
        // Aca manejo esto por los cambios que se pueden dar, no se donde mas ponerlo, pues el VC debe mandarle el closure al VM
        apiClient.resourceAPI.baseURL = NetworkingConstants.BASE_URL
        apiClient.resourceAPI.path = NetworkingConstants.PEOPLE_URL
        apiClient.resourceAPI.page = 1
        peopleTableViewModel = PeopleTableViewModel(request: apiClient.getPeopleResponse)
    }
    
    /**
     Sets up the table view.
     */
    private func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
    }
    
    /**
     Sets up the table view data by binding itself to the ViewModel peopleList observable.
     */
    private func setupTableViewBinding() {
        
        if let peopleList = peopleTableViewModel?.peopleList {
            peopleList
                .bind(to: tableView.rx.items(cellIdentifier: UIConstants.PERSON_CELL_IDENTIFIER, cellType: PeopleTableViewCell.self)) { (row, element, cell) in
                    
                    self.customizePersonCell(cell, row, element.name, element.gender.rawValue.capitalizingFirstLetter())
                    
                }
                .disposed(by: disposeBag)
        }
        
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
}
