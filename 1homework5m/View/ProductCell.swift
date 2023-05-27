//
//  ProductCell.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ProductCell: UITableViewCell{
    
    private lazy var mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 24, weight: .thin)
        return view
    }()
    
    private lazy var ratingTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        return view
    }()
    
    private lazy var categoryTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }
        addSubview(mainTitle)
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(3)
            make.width.lessThanOrEqualToSuperview().dividedBy(2)
        }
        let openTitle: UILabel = {
            let view = UILabel()
            view.font = .systemFont(ofSize: 24, weight: .thin)
            view.text = "OPEN"
            view.textColor = UIColor(red: 0.36, green: 0.59, blue: 0.16, alpha: 1.0)
            return view
        }()
        
        addSubview(openTitle)
        openTitle.snp.makeConstraints { make in
            make.centerY.equalTo(mainTitle)
            make.left.equalTo(mainTitle.snp.right).offset(10)
        }
        
        let starImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.tintColor = .orange
            return view
        }()
        
        addSubview(starImage)
        starImage.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(12)
            make.height.equalTo(13)
        }
        starImage.image = UIImage(systemName: "star.fill")
        
        addSubview(ratingTitle)
        ratingTitle.snp.makeConstraints { make in
            make.centerY.equalTo(starImage)
            make.left.equalTo(starImage.snp.right).offset(6.5)
        }
        
        addSubview(categoryTitle)
        categoryTitle.snp.makeConstraints { make in
            make.centerY.equalTo(ratingTitle)
            make.left.equalTo(ratingTitle.snp.right).offset(10)
        }
        
        let bottomLabel: UILabel = {
            let view = UILabel()
            view.font = .systemFont(ofSize: 12, weight: .medium)
            view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
            view.text = "Delivery: Free - Minimum: \(Int.random(in: 10...1000))$"
            return view
        }()
        
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainTitle)
            make.top.equalTo(starImage.snp.bottom).offset(5)
        }
        
        let preparationLabel: UILabel = {
            let view = UILabel()
            view.font = .systemFont(ofSize: 14, weight: .thin)
            view.text = "\(Int.random(in: 0...50)) - \(Int.random(in: 50..<100)) min"
            view.textColor = .white
            view.textAlignment = .center
            view.backgroundColor = UIColor(red: 1, green: 0.77, blue: 0.27, alpha: 1)
            return view
        }()
        
        addSubview(preparationLabel)
        preparationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(21)
            make.width.equalTo(77)
            make.height.equalTo(33)
            make.centerY.equalTo(mainTitle)
        }
        
        let locationImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.tintColor = .gray
            view.image = UIImage(systemName: "location.fill")
            return view
        }()
        
        let destinationLabel: UILabel = {
            let view = UILabel()
            view.font = .systemFont(ofSize: 14, weight: .thin)
            view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
            view.text = String(format: "%.1f", Double.random(in: 0...50)) + " km away"
            return view
        }()
        
        addSubview(destinationLabel)
        destinationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalTo(bottomLabel.snp.top)
        }
        
        addSubview(locationImage)
        locationImage.snp.makeConstraints { make in
            make.centerY.equalTo(bottomLabel.snp.top)
            make.trailing.equalTo(destinationLabel.snp.leading)
            make.width.height.equalTo(12)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(title: String, image: String,rating: Double,category:String){
        mainImage.kf.setImage(with: URL(string: image))
        mainTitle.text = title
        ratingTitle.text = "\(rating) (\(Int.random(in: 0...100)))"
        categoryTitle.text = category
    }
    
}

