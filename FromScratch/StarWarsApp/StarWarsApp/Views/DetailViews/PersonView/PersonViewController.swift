//
//  PersonViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// swiftlint:disable:next line_length
class PersonViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var apiClient: APIClient!
    private var personViewModel: PersonViewModel!
    private let disposeBag = DisposeBag()

    // Subviews
    var scrollView = UIScrollView()
    var contentView = UIView()
    var personImageView = UIImageView(image: #imageLiteral(resourceName: "bb8"))
    var nameLabel = UILabel()
    var genderLabel = UILabel()
    var heightLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()
    var collectionView: UICollectionView!
    var pagingControl = UIPageControl()

    let backgroundImages = [#imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "m-falcon"), #imageLiteral(resourceName: "tatooine")]
    let characterImages = [#imageLiteral(resourceName: "resistance"), #imageLiteral(resourceName: "characters"), #imageLiteral(resourceName: "dark-side"), #imageLiteral(resourceName: "robots"), #imageLiteral(resourceName: "jedis")]

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

    init(_ person: Person, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        personViewModel =
            PersonViewModel( request: { self.apiClient.requestAPIResource(PlanetAPI($0)) }, person: person)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupBindings()
    }

    /**
     Bind the subviews data.
     */
    private func setupBindings() {
        /// Name
        personViewModel.personName
            .asObservable()
            .map { String(format: "\(R.string.localizable.nameLabel())%@", $0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Gender
        personViewModel.personGender
            .asObservable()
            .map { String(format: "\(R.string.localizable.genderLabel())%@", $0) }
            .bind(to: genderLabel.rx.text)
            .disposed(by: disposeBag)

        /// Height
        personViewModel.personHeight
            .asObservable()
            .map { String(format: "\(R.string.localizable.heightLabel())%@ ft", $0) }
            .bind(to: heightLabel.rx.text)
            .disposed(by: disposeBag)

        /// Homeworld
        personViewModel.personHomeworld
            .asObservable()
            .map { String(format: "\(R.string.localizable.homeworldLabel())%@", $0) }
            .bind(to: homeworldLabel.rx.text)
            .disposed(by: disposeBag)

        Observable.timer(0, period: 5.0, scheduler: MainScheduler.instance)
            .map { self.backgroundImages[$0 % self.backgroundImages.count] }
            .subscribe(onNext: { [weak self] in
                self?.backgroundImageView.crossDissolveImage($0)
            })
            .disposed(by: disposeBag)

    }

    // The next functions are for the image slider

    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath)
        guard let collectionCell = cell as? CollectionViewCell else {
            return CollectionViewCell()
        }

        collectionCell.setImage(characterImages[indexPath.row])
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterImages.count
    }

    // swiftlint:disable:next line_length
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    // swiftlint:disable:next line_length
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }

    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pagingControl.currentPage = Int(round(scrollView.contentOffset.x / 320))
    }
}
