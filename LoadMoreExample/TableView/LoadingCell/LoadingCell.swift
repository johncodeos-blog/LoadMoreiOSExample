//
//  LoadingCell.swift
//  LoadMoreExample
//
//  Created by John Codeos on 10/14/2019.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        activityIndicator.color = UIColor.white
    }
}
