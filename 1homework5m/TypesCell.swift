//
//  TypesCell.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import Foundation

import UIKit
import SnapKit

class TypesCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override func layoutSubviews(){
        
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 1
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = UIColor(red: 0.36, green: 0.59, blue: 0.16, alpha: 1.0)
        label.textAlignment = .center
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    func fill(text: String){
        label.text = text
    }
}
