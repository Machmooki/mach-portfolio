//
//  StatementViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit
import WebKit

class StatementViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webContainerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)

        webView = WKWebView(frame: webContainerView.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webContainerView.addSubview(webView)

        loadPage()
    }

    func loadPage() {
        guard let statement = PortfolioDataService.shared.data?.statementOfPurpose,
              let html = makeHTML(from: statement) else {
            showError("Statement of Purpose could not be loaded.")
            return
        }
        loadingIndicator.startAnimating()
        webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
    }

    func showError(_ message: String) {
        loadingIndicator.stopAnimating()
        webView.isHidden = true
        errorMessageLabel.text = message
        errorView.isHidden = false
    }


    func makeHTML(from statement: StatementOfPurpose) -> String? {
        guard let url = Bundle.main.url(forResource: "Statement", withExtension: "html"),
              var html = try? String(contentsOf: url, encoding: .utf8) else {
            return nil
        }

        var cardsHTML = ""
        for section in statement.sections {
            cardsHTML += """
            <article class="card">
              <div class="card-head">
                <svg class="icon" aria-hidden="true"><use href="#icon-\(escape(section.icon))"/></svg>
                <span class="num">\(escape(section.number))</span>
              </div>
              <h2>\(escape(section.title))</h2>
              <p>\(escape(section.description))</p>
            </article>
            """
        }

        html = html.replacingOccurrences(of: "{{SECTIONS}}", with: cardsHTML)
        return html
    }

    func escape(_ text: String) -> String {
        return text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(error.localizedDescription)
    }
}
