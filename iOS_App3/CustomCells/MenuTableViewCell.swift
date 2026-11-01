//
//  MenuTableViewCell.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!

    func configure(with item: MenuItem) {
        iconImageView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
