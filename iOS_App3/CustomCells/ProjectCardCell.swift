//
//  ProjectCardCell.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class ProjectCardCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var technologiesLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var viewProjectButton: UIButton!

    var onViewProject: (() -> Void)?

    func configure(with project: Project, index: Int) {
        coverImageView.image = UIImage(named: project.imageName)
        indexLabel.text = String(format: "%02d", index + 1)
        categoryLabel.text = project.category.uppercased()
        nameLabel.text = project.name
        descriptionLabel.setText(project.description, lineSpacing: 1.25)
        technologiesLabel.text = project.technologies.joined(separator: "  ·  ")
        linkLabel.text = project.url?.host ?? "Invalid URL"
    }

    @IBAction func viewProjectTapped(_ sender: UIButton) {
        onViewProject?()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        cardView.alpha = highlighted ? 0.85 : 1
    }
}
