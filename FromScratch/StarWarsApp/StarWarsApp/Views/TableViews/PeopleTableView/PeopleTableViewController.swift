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

    override func loadView() {
        super.loadView()

        setupLoadingScreen()
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

        peopleTableViewModel?.peopleList
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: "PersonCell", cellType: PeopleTableViewCell.self)) { [ weak self ] (row, element, cell) in
                    self?.customizePersonCell(cell, row, element.name, element.gender.rawValue)
                    self?.loadingScreenView.hideLoadingScreen()
                }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Person.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                // swiftlint:disable:next line_length
                self?.navigationController?.pushViewController(PersonViewController(model, (self?.apiClient)!), animated: true)
            }).disposed(by: disposeBag)

        tableView.rx.reachedBottom.asDriver()
            .drive(peopleTableViewModel.nextPageTrigger)
            .disposed(by: disposeBag)

    }

}

extension PeopleTableViewController: APIClientInyectionProtocol {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
