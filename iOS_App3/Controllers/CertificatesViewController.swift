//
//  CertificatesViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class CertificatesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var emptyStateLabel: UILabel!

    var certificates: [Certificate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)

        certificates = PortfolioDataService.shared.data?.certificates ?? []
        emptyStateLabel.isHidden = !certificates.isEmpty
        collectionView.isHidden = certificates.isEmpty
        pageControl.isHidden = certificates.isEmpty
        counterLabel.isHidden = certificates.isEmpty

        pageControl.numberOfPages = certificates.count
        showPage(0)
    }

    func showPage(_ page: Int) {
        pageControl.currentPage = page
        counterLabel.text = String(format: "%02d / %02d", page + 1, certificates.count)
    }

    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        showPage(sender.currentPage)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certificates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificateCollectionViewCell", for: indexPath) as! CertificateCollectionViewCell
        cell.configure(with: certificates[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let certificate = certificates[indexPath.item]
        guard let image = UIImage(named: certificate.imageName) else { return }
        let previewVC = ImagePreviewViewController(image: image, title: certificate.name)
        present(previewVC, animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        showPage(page)
    }
}
