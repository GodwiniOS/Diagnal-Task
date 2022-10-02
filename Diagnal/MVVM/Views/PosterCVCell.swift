//
//  PosterCVCell.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import UIKit

class PosterCVCell: UICollectionViewCell {
    
    
    let backGroundView = UIView()
    let posterView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        prepareTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func prepareTableViewCell(){
        
        contentView.backgroundColor = .black

        contentView.addSubview(backGroundView)
        backGroundView.prepareLayout(.leading)
        backGroundView.prepareLayout(.trailing)
        backGroundView.prepareLayout(.top)
        backGroundView.prepareLayout(.bottom,constant: -(40.px))
        backGroundView.backgroundColor = .black
        

        backGroundView.addSubview(posterView)
        posterView.prepareLayout(.top)
        posterView.prepareLayout(.leading)
        posterView.prepareLayout(.trailing)
        posterView.prepareLayout(.bottom,constant: -(76.px))

        posterView.backgroundColor = .black
        posterView.contentMode = .scaleAspectFit
        
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(.trailing)
        titleLabel.prepareLayout(.leading)
//        titleLabel.prepareLayout(.height,constant: 16.px)
        titleLabel.prepareLayout(.bottom)
        titleLabel.backgroundColor = .black
        titleLabel.prepareTextField(fontName: .Light,
                                    size: .title,color: .white)
        titleLabel.numberOfLines = 0

    }
    
    func prepare(_ vm: ContentModel) {
        
        titleLabel.text = vm.name
        posterView.preparePosterImage(name: vm.posterimage)
    }
}
