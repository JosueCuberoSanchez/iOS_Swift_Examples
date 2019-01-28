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

    @IBOutlet weak var searchBar: UISearchBar!

    override func loadView() {
        super.loadView()

        setupLoadingScreen(loadingScreenView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        starshipsTableViewModel =
            StarshipsTableViewModel(request: { self.apiClient.requestAPIResource(StarshipsResource($0)) })
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
     Sets up the table view data by binding itself to the ViewModel starshipList observable.
     */
    private func setupTableViewBindings() {

        starshipsTableViewModel.starshipList
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: "StarshipCell", cellType: TabListTableViewCell.self)) { [ weak self ] (row, element, cell) in
                self?.customizeCell(cell, row, element.name, element.manufacturer)
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Starship.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                if let apiClient = self?.apiClient {
                    self?.navigationController?
                        .pushViewController(StarshipViewController(model, apiClient), animated: true)
                }
            }).disposed(by: disposeBag)

        tableView.rx.reachedBottom
            .bind(to: starshipsTableViewModel.nextPageTrigger)
            .disposed(by: disposeBag)

        searchBar.rx.text
            .orEmpty
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: starshipsTableViewModel.filterSource)
            .disposed(by: disposeBag)

    }

}

extension StarshipsTableViewController: APIClientInjection {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
