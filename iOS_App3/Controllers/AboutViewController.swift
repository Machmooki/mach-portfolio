//
//  AboutViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit
import AVKit

class AboutViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var videoPlaceholderView: UIView!

    @IBOutlet weak var introSection: UIView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var educationSection: UIView!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var skillsSection: UIView!
    @IBOutlet weak var skillsTagView: TagFlowView!
    @IBOutlet weak var interestsSection: UIView!
    @IBOutlet weak var interestsTagView: TagFlowView!
    @IBOutlet weak var backgroundSection: UIView!
    @IBOutlet weak var backgroundLabel: UILabel!

    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)

        guard let profile = PortfolioDataService.shared.data?.profile else { return }
        showProfile(profile)
        setupVideo(fileName: profile.introVideoName)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if presentedViewController == nil {
            player?.pause()
        }
    }

    func showProfile(_ profile: Profile) {
        profileImageView.image = UIImage(named: profile.profileImageName)
        nameLabel.text = profile.name
        titleLabel.text = profile.title.trimmingCharacters(in: .whitespaces)
        titleLabel.isHidden = titleLabel.text?.isEmpty ?? true

        introLabel.setText(profile.introduction)
        introSection.isHidden = profile.introduction.isEmpty

        let educationText = profile.education.map { "•  " + $0 }.joined(separator: "\n")
        educationLabel.setText(educationText)
        educationSection.isHidden = profile.education.isEmpty

        skillsTagView.setTags(profile.skills)
        skillsSection.isHidden = profile.skills.isEmpty

        interestsTagView.setTags(profile.interests)
        interestsSection.isHidden = profile.interests.isEmpty

        let background = profile.background ?? ""
        backgroundLabel.setText(background)
        backgroundSection.isHidden = background.isEmpty
    }

    func setupVideo(fileName: String) {
        let name = (fileName as NSString).deletingPathExtension
        let type = (fileName as NSString).pathExtension

        guard let url = Bundle.main.url(forResource: name, withExtension: type) else {
            videoPlaceholderView.isHidden = false
            return
        }
        videoPlaceholderView.isHidden = true

        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.backgroundColor = .black

        addChild(playerController)
        videoContainerView.insertSubview(playerController.view, at: 0)
        playerController.view.frame = videoContainerView.bounds
        playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerController.didMove(toParent: self)

        self.player = player
    }
}
