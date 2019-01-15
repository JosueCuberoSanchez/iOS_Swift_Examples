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
    var peopleTableViewModel: PeopleTableViewModel
    var loadingScreenView = LoadingScreenView()
    
    private final let peopleMaxPage = 80
    private final let peopleResource = "people/"
    
    required init?(coder aDecoder: NSCoder) {
        let resource = Resource(peopleResource)
        peopleTableViewModel = PeopleTableViewModel(request: apiClient.getResponse(resource))
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreen()
        setupTableView()
        setupTableViewBindings()
    }
    
    /**
     Sets a loading screen as subview of the tableView while the data is being fetched.
     */
    private func setLoadingScreen() {
        loadingScreenView.setLoadingScreen((navigationController?.navigationBar.frame.height)!, tableView)
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
    private func setupTableViewBindings() {
        
        // Bind the cells to each of the ViewModel peopleList models.
        peopleTableViewModel.peopleList?
            .drive(tableView.rx.items(cellIdentifier: R.string.localizable.personCellID(), cellType: PeopleTableViewCell.self)) { [ weak self ] (row, element, cell) in
                
                self?.customizePersonCell(cell, row, element.name, element.gender.rawValue)
                self?.loadingScreenView.removeLoadingScreen()

            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self).asDriver().drive(onNext: { [ weak self ] model in
            
            // This way does not show me a black screen on segue
            let personViewController: PersonViewController =
                self?.storyboard?.instantiateViewController(withIdentifier: R.string.localizable.personViewControllerID()) as! PersonViewController
            personViewController.setPerson(Driver.of(model))
            self?.navigationController?.pushViewController(personViewController, animated: true)
            
        }).disposed(by: disposeBag)
        
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
        
        guard (rowCount == indexPath.row && rowCount < peopleMaxPage) else { return }
        
        loadingScreenView.showLoadingScreen()
        peopleTableViewModel.nextPageTrigger.accept(())
        
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
