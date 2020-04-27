//
//  AppearanceViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol AppearanceDelegate: class {
    
}

class AppearanceViewController: UIViewController {
    var viewModel: AppearanceViewModeling?
    var router: AppearanceRoutering?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoLabel: UILabel!
    
    private enum Constant {
        static let appearance = "Appearance"
        static let chatBackground = "Chat Background"
        static let cellID = "AppearanceCollectionViewCell"
        static let arrayImage = ["img1", "img2", "img3", "img4", "img5", "img"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        infoLabel.text = Constant.chatBackground
        navigationItem.title = Constant.appearance
        collectionView.register(UINib(nibName: Constant.cellID, bundle: nil), forCellWithReuseIdentifier: Constant.cellID)
    
        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = AppearanceViewModel(view: self)
        router = AppearanceRouter(viewController: self)
    }
}

extension AppearanceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellID,
                                                      for: indexPath) as! AppearanceCollectionViewCell
        
        if let picture = UIImage(named: Constant.arrayImage[indexPath.row]) {
            cell.pictureImageView.contentMode = .scaleToFill
            cell.setupCell(picture: picture)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel?.saveSetting(image: Constant.arrayImage[indexPath.row])
    }
}

extension AppearanceViewController: AppearanceDelegate {
    
}
