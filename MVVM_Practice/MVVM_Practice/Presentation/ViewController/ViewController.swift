//
//  ViewController.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import UIKit

import SnapKit
import Then

final class ViewController: UIViewController {
    
    lazy var randomUserViewModel = RandomUserViewModel()
    
    let homeTitleLabel = UILabel()
    lazy var randomUserCollectionView = UICollectionView(frame: .zero, collectionViewLayout: randomUserFlowLayout)
    let randomUserFlowLayout = UICollectionViewFlowLayout()
    let randomButton = UIButton()
    
    let paddingValue: Double = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        randomUserViewModel.networkRandomUser()

        setUI()
        setCollectionView()
        setAddTarget()
    }
    
    private func setCollectionView() {
        self.randomUserCollectionView.delegate = self
        self.randomUserCollectionView.dataSource = self
        self.randomUserCollectionView.register(RandomUserCollectionViewCell.self, forCellWithReuseIdentifier: RandomUserCollectionViewCell.identifier)
    }
    
    private func setAddTarget() {
        self.randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomButtonTapped() {
        randomUserViewModel.networkRandomUser()
        randomUserCollectionView.reloadData()
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        homeTitleLabel.do {
            $0.text = "Random User"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 30)
        }
        
        randomUserFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - CGFloat(paddingValue * 2), height: 80)
            $0.minimumLineSpacing = 0
        }
        
        randomButton.do {
            $0.clipsToBounds = true
            $0.setImage(UIImage(systemName: "shuffle.circle.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.tintColor = .black
            $0.imageView?.contentMode = .scaleToFill
        }
    }
    
    private func setLayout() {
        view.addSubviews(homeTitleLabel,
                         randomUserCollectionView,
                         randomButton)
        
        homeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
        }
        
        randomUserCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(paddingValue)
            $0.top.equalTo(homeTitleLabel.snp.bottom).offset(50)
            $0.height.equalTo(320)
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(randomUserCollectionView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}

extension ViewController: UICollectionViewDelegate { }

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomUserViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomUserCollectionViewCell.identifier, for: indexPath) as? RandomUserCollectionViewCell else { return UICollectionViewCell() }
        let personData = randomUserViewModel.person[indexPath.row]
        cell.configCell(data: personData)
        cell.layoutIfNeeded()

        return cell
    }
}
