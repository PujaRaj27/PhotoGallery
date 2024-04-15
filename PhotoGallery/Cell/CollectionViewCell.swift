//
//  CollectionViewCell.swift
//  PhotoGallery
//
//  Created by PujaRaj on 15/04/24.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - properties
    
    static var collectionViewId = "collectionViewCell"
    
    //MARK: - IBOutlets
    
    let myImageView: ImgView = {
        let image = ImgView()
        return image
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    //MARK: - Set Layouts
    
    override func layoutSubviews() {
        myImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    
}
