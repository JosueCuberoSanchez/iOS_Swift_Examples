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

class StarshipsTableViewController: GenericTableViewController<StarshipsTableViewModel> {

    override func viewDidLoad() {
        viewModel =
            StarshipsTableViewModel(request: { self.apiClient.requestAPIResource(StarshipsResource($0)) })

        super.viewDidLoad()

        tableView.rx.modelSelected(Starship.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                if let apiClient = self?.apiClient {
                    self?.navigationController?
                        .pushViewController(StarshipViewController(model, apiClient), animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setCellLabelContents(_ cell: TabListTableViewCell, _ model: Starship) {
        cell.nameLabel.text = model.name
        cell.detailLabel.text = model.manufacturer
    }
}
