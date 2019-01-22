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

class StarshipsTableViewController: UITableViewController {

    private var apiClient: APIClient!
    private var starshipsTableViewModel: StarshipsTableViewModel!
    private let disposeBag = DisposeBag()
    var loadingScreenView = LoadingScreenView()

    override func loadView() {
        super.loadView()

        setupLoadingScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        starshipsTableViewModel =
            StarshipsTableViewModel(request: { return self.apiClient.requestAPIResource(StarshipsAPI($0)) })
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

        starshipsTableViewModel?.starshipList
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: "StarshipCell", cellType: StarshipsTableViewCell.self)) { [ weak self ] (row, element, cell) in
                self?.customizeStarshipCell(cell, row, element.name, element.manufacturer)
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Starship.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                // swiftlint:disable:next line_length
                self?.navigationController?.pushViewController(StarshipViewController(model, (self?.apiClient)!), animated: true)
            }).disposed(by: disposeBag)

        tableView.rx.reachedBottom
            .bind(to: starshipsTableViewModel.nextPageTrigger)
            .disposed(by: disposeBag)

    }

}

extension StarshipsTableViewController: APIClientInyectionProtocol {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
