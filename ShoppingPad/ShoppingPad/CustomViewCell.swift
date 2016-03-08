//
//  CustomViewCell.swift
//  ShoppingPad
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    
    
    //TableViewcell atributes
    @IBOutlet weak var mContentCellImageView: UIImageView!
    
    @IBOutlet weak var mContentCellTitleLabel: UILabel!
    
    @IBOutlet weak var mContentCellViewAction: UILabel!
    
    @IBOutlet weak var mContentCellLastSeen: UILabel!

    @IBOutlet weak var mContentCellTotalViews: UILabel!
    
    @IBOutlet weak var mContentCellTotalParticipants: UILabel!
    
    //create object of view
    var mContentListViewControllerObj = ContentListViewController()
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
