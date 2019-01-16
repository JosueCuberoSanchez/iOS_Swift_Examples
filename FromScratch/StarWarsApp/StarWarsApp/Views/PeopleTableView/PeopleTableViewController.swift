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
    
    private let apiClient: APIClient
    private let peopleTableViewModel: PeopleTableViewModel
    private let disposeBag = DisposeBag()
    private var loadingScreenView = LoadingScreenView()
    
    private final let peopleMaxPage = 80
    private final let peopleResource = "people/"
    
    required init?(coder aDecoder: NSCoder) {
        
        // Get app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        apiClient = appDelegate.apiClient
        
        // Setup view model
        let resource = Resource(peopleResource)
        peopleTableViewModel = PeopleTableViewModel(request: apiClient.getResponse(resource))
        
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        
        setupLoadingScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewBindings()
    }
    
    /**
     Sets up the loading screen.
     */
    private func setupLoadingScreen() {
                
        view.addSubview(loadingScreenView)
        
        NSLayoutConstraint.activate([
            loadingScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingScreenView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loadingScreenView.showLoadingScreen()
    }
    
    /**
     Sets up the table view delegates and data source.
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
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                self?.navigationController?.pushViewController(PersonViewController(model), animated: true)
            }).disposed(by: disposeBag)
        
        tableView.rx.reachedBottom.asObservable()
            .debounce(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext:{
                self.peopleTableViewModel.nextPageTrigger.accept(())
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
    
}

// Taken from: https://github.com/tryswift/RxPagination/blob/master/Pagination/UIScrollView%2BRx.swift
// Detects when user has reached the bottom of the table view's scroll view
extension Reactive where Base: UIScrollView {
    var reachedBottom: ControlEvent<Void> {
        let observable = contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y > threshold ? Observable.just(()) : Observable.empty()
        }
        
        return ControlEvent(events: observable)
    }
}
