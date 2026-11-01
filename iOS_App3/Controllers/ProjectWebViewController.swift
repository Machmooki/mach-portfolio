//
//  ProjectWebViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit
import WebKit

class ProjectWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webContainerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    @IBOutlet weak var reloadItem: UIBarButtonItem!

    var project: Project?
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)
        title = project?.name

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: webContainerView.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webContainerView.addSubview(webView)

        loadWebsite()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }

    func loadWebsite() {
        guard let url = project?.url else {
            showError(title: "Invalid URL", message: "Please check ProjectURL in PortfolioData.plist.")
            return
        }
        errorView.isHidden = true
        webView.load(URLRequest(url: url))
    }

    func showError(title: String, message: String) {
        loadingIndicator.stopAnimating()
        errorTitleLabel.text = title
        errorMessageLabel.text = message
        errorView.isHidden = false
    }

    func updateToolbar() {
        backItem.isEnabled = webView.canGoBack
        forwardItem.isEnabled = webView.canGoForward
    }


    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }

    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }

    @IBAction func reloadOrStop(_ sender: UIBarButtonItem) {
        if webView.url == nil {
            loadWebsite()
        } else {
            errorView.isHidden = true
            webView.reload()
        }
    }

    @IBAction func retryTapped(_ sender: UIButton) {
        loadWebsite()
    }


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator.startAnimating()
        updateToolbar()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
        updateToolbar()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleLoadError(error)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleLoadError(error)
    }

    func handleLoadError(_ error: Error) {
        if (error as NSError).code == NSURLErrorCancelled {
            return
        }
        showError(title: "Unable to load website", message: error.localizedDescription)
    }


    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        webView.load(navigationAction.request)
        return nil
    }
}
