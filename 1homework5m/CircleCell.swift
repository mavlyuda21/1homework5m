//
//  CircleCell.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import Foundation
import UIKit
import SnapKit

struct Circle{
    var name, image: String
}

class CircleCell: UICollectionViewCell{
    
    
    var circle: Circle? {
        didSet{
            if let image = circle?.image{
                circleImage.image = UIImage(named: image)
            }
            self.titleName.text = circle?.name
        }
    }
    
    private lazy var circleImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = self.frame.width / 2
        view.backgroundColor = .red
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleName: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15,weight: .thin)
        view.textColor = .black
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private func setupSubviews(){
        addSubview(circleImage)
        circleImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        addSubview(titleName)
        titleName.snp.makeConstraints { make in
            make.top.equalTo(circleImage.snp.bottom).offset(10)
            make.centerX.equalTo(circleImage)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
