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

    private var apiClient: APIClient!
    private var peopleTableViewModel: PeopleTableViewModel!
    private let disposeBag = DisposeBag()
    var loadingScreenView = LoadingScreenView()

    // Searching helpers
    let filterSource = BehaviorRelay<String>(value: "")
    @IBOutlet weak var searchBar: UISearchBar!

    override func loadView() {
        super.loadView()

        setupLoadingScreen(loadingScreenView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableViewModel =
            PeopleTableViewModel(request: { return self.apiClient.requestAPIResource(PeopleAPI($0)) })
        loadingScreenView.showLoadingScreen()
        setupTableView()
        setupTableViewBindings()
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

        Driver.combineLatest(peopleTableViewModel.peopleList, filterSource.asDriver()) { data, filter in
            data.filter { person in
                if filter == "" {
                    return true
                }
                return person.name.contains(filter)
            }
        }
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: "PersonCell", cellType: TableViewCell.self)) { [ weak self ] (row, element, cell) in
                self?.customizeCell(cell, row, element.name, element.gender.rawValue)
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Person.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                // swiftlint:disable:next line_length
                self?.navigationController?.pushViewController(PersonViewController(model, (self?.apiClient)!), animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.reachedBottom
            .bind(to: peopleTableViewModel.nextPageTrigger)
            .disposed(by: disposeBag)

        searchBar.rx.text
            .orEmpty
            .debounce(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { self.filterSource.accept($0) })
            .disposed(by: disposeBag)

    }

}

extension PeopleTableViewController: APIClientInjectionProtocol {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
