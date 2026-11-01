//
//  ActivitiesViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class ActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!

    var projects: [Project] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)

        projects = PortfolioDataService.shared.data?.visibleProjects ?? []
        emptyStateLabel.isHidden = !projects.isEmpty
        tableView.isHidden = projects.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProject",
           let webVC = segue.destination as? ProjectWebViewController,
           let index = sender as? Int {
            webVC.project = projects[index]
        }
    }

    func openProject(at index: Int) {
        performSegue(withIdentifier: "showProject", sender: index)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCardCell", for: indexPath) as! ProjectCardCell
        cell.configure(with: projects[indexPath.row], index: indexPath.row)
        cell.onViewProject = { [weak self] in
            self?.openProject(at: indexPath.row)
        }
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openProject(at: indexPath.row)
    }
}
