//
//  DataItemHeader.swift
//  CollectionViewDemo
//
//  Created by Chris Hahn on 7/11/17.
//  Copyright © 2017 Sturnella. All rights reserved.
//

import UIKit

class DataItemHeader: UICollectionReusableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
}
