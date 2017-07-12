//
//  DataItemCell.swift
//  CollectionViewDemo
//
//  Created by Chris Hahn on 7/11/17.
//  Copyright © 2017 Sturnella. All rights reserved.
//

import UIKit

class DataItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var dataItemImageView: UIImageView!
    
    var dataItem: DataItem? {
        didSet {
            if let dataItem = dataItem {
                dataItemImageView.image = UIImage(named: dataItem.imageName)
            }
        }
    }

}
