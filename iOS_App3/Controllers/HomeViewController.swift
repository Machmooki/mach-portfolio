//
//  HomeViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var contentGroupView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!

    private var didAnimate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)

        guard let profile = PortfolioDataService.shared.data?.profile else { return }
        profileImageView.image = UIImage(named: profile.profileImageName)
        nameLabel.text = profile.name
        titleLabel.text = profile.title.trimmingCharacters(in: .whitespaces)
        titleLabel.isHidden = titleLabel.text?.isEmpty ?? true
        introLabel.setText(profile.introduction, lineSpacing: 1.35)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didAnimate else { return }
        didAnimate = true

        for (index, view) in contentGroupView.subviews.enumerated() {
            view.alpha = 0
            UIView.animate(withDuration: 0.6, delay: 0.06 * Double(index)) {
                view.alpha = 1
            }
        }
    }
}
