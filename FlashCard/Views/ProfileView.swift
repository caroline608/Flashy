//
//  ProfileView.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ProfileView: UIView {

   
    lazy var profileBGImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "stars")
        return imageView
    }()
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "lovely")
        return imageView
    }()
    
    
    lazy var profileFlashCardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSpacing: CGFloat = 10.0
        let itemWidth: CGFloat = bounds.width - (cellSpacing * 2)
        let itemHeight: CGFloat = bounds.height * 0.35
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing * 2
        layout.minimumInteritemSpacing = cellSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(FlashCardCollectionViewCell.self, forCellWithReuseIdentifier: "flashCardCell")
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width/2.0
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.borderColor = UIColor.white.cgColor
        userProfileImageView.layer.borderWidth = 4
    }
    
    private func setupViews() {
        setupProfileBGImageView()
        setupUserFlashCardsCollectionView()
        setupUserProfileImageView()
    }
    
    private func setupProfileBGImageView() {
        addSubview(profileBGImageView)
        profileBGImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setupUserFlashCardsCollectionView() {
        addSubview(profileFlashCardsCollectionView)
        profileFlashCardsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(profileBGImageView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupUserProfileImageView() {
        addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileBGImageView.snp.bottom)
            make.centerX.equalTo(profileBGImageView.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
            make.height.equalTo(userProfileImageView.snp.width)
        }
    }
    
}
