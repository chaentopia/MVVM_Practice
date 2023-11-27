//
//  RandomUserCollectionViewCell.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class RandomUserCollectionViewCell: UICollectionViewCell {
    static let identifier = "RandomUserCollectionViewCell"
    
    let profileImage = UIImageView()
    let labelStackView = UIStackView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        self.backgroundColor = .clear
        
        profileImage.do {
            $0.layer.cornerRadius = self.profileImage.bounds.height / 2
            $0.clipsToBounds = true
        }
        
        labelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        nameLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .left
        }
        
        emailLabel.do {
            $0.textColor = .darkGray
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .left
        }
    }
    
    func setLayout() {
        self.addSubviews(profileImage,
                         labelStackView)
        
        [nameLabel, emailLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(40)
            $0.centerY.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints {            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configCell(data: Person) {
        guard let url = URL(string: data.profileImage) else { return }
        profileImage.kf.setImage(with: url)
        nameLabel.text = data.name
        emailLabel.text = data.emailAddress
    }
}
