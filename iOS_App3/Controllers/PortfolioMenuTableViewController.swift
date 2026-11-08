//
//  PortfolioMenuTableViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

struct MenuItem {
    let title: String
    let subtitle: String
    let icon: String
    let segueIdentifier: String
}

class PortfolioMenuTableViewController: UITableViewController {

    let menuItems = [
        MenuItem(title: "About Me", subtitle: "Personal Profile & Background", icon: "person.crop.circle", segueIdentifier: "showAbout"),
        MenuItem(title: "Statement of Purpose", subtitle: "Inspiration & Future Goals", icon: "lightbulb", segueIdentifier: "showStatement"),
        MenuItem(title: "Activities & Works", subtitle: "Projects & Experiences", icon: "folder", segueIdentifier: "showActivities"),
        MenuItem(title: "Certificates", subtitle: "Achievements & Certifications", icon: "rosette", segueIdentifier: "showCertificates"),
        MenuItem(title: "Places of Interest", subtitle: "5 Special Places on the Map", icon: "map", segueIdentifier: "showPlaces")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.configure(with: menuItems[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let data = PortfolioDataService.shared.data else { return nil }
        return "\(data.visibleProjects.count) projects · \(data.certificates.count) certificates"
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: menuItems[indexPath.row].segueIdentifier, sender: self)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.alpha = 0
        UIView.animate(withDuration: 0.45, delay: 0.06 * Double(indexPath.row)) {
            cell.contentView.alpha = 1
        }
    }
}
