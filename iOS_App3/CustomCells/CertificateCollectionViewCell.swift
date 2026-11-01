//
//  CertificateCollectionViewCell.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class CertificateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var certificateImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(with certificate: Certificate) {
        certificateImageView.image = UIImage(named: certificate.imageName)
        nameLabel.text = certificate.name
        descriptionLabel.setText(certificate.description, lineSpacing: 1.25)
    }

    override var isHighlighted: Bool {
        didSet { cardView.alpha = isHighlighted ? 0.85 : 1 }
    }
}
