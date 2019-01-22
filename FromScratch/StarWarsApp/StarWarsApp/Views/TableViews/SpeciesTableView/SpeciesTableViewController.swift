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

class SpeciesTableViewController: UITableViewController {

    private var apiClient: APIClient!
    private var speciesTableViewModel: SpeciesTableViewModel!
    private let disposeBag = DisposeBag()
    var loadingScreenView = LoadingScreenView()

    override func loadView() {
        super.loadView()

        setupLoadingScreen(loadingScreenView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        speciesTableViewModel =
            SpeciesTableViewModel(request: { return self.apiClient.requestAPIResource(SpeciesAPI($0)) })
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

        speciesTableViewModel?.specieList
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: "SpecieCell", cellType: TableViewCell.self)) { [ weak self ] (row, element, cell) in
                self?.customizeCell(cell, row, element.name, element.classification)
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Specie.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                // swiftlint:disable:next line_length
                self?.navigationController?.pushViewController(SpecieViewController(model, (self?.apiClient)!), animated: true)
            }).disposed(by: disposeBag)

        tableView.rx.reachedBottom
            .bind(to: speciesTableViewModel.nextPageTrigger)
            .disposed(by: disposeBag)

    }

}

extension SpeciesTableViewController: APIClientInyectionProtocol {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
