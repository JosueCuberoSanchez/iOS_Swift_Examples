//
//  PeopleTableTestViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/29/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

class PeopleTableViewController: GenericTableViewController<PeopleTableViewModel> {

    override func viewDidLoad() {
        viewModel =
            PeopleTableViewModel(request: { PeopleResource($0).execute(with: self.apiClient, using: self.jsonDecoder) })

        super.viewDidLoad()

        tableView.rx.modelSelected(Person.self).asDriver()
            .drive(onNext: { [ weak self ] model in
                if let apiClient = self?.apiClient {
                    self?.navigationController?
                        .pushViewController(PersonViewController(model, apiClient), animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setCellLabelContents(_ cell: TabListTableViewCell, _ model: Person) {
        cell.nameLabel.text = model.name
        cell.detailLabel.text = model.gender.rawValue
    }

}
