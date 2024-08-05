//
//  DetailViewController.swift
//  Project-4
//
//  Created by Kevin Cuadros on 5/08/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webSite: String!
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["google.com", "hackingwithswift.com", "kevincuadros.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(opentapped)
        )
        
        
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let refresh = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView.reload)
        )
        
        // Try making two new toolbar items with the
        // titles Back and Forward. You should make
        // them use webView.goBack and webView.goForward.
        let back = UIBarButtonItem(
            barButtonSystemItem: .fastForward,
            target: webView,
            action: #selector(webView.goBack)
        )
        let forward = UIBarButtonItem(
            barButtonSystemItem: .camera,
            target: webView,
            action: #selector(webView.goForward)
        )
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(
            self,
            forKeyPath: "estimatedProgress",
            options: .new,
            context: nil
        )

        
        let url = URL(string: "https://" + webSite)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        webIsBlocked()
    }
    
    @objc func opentapped() {
        let ac = UIAlertController(
            title: "Open page...",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        for website in websites {
            ac.addAction(UIAlertAction(
                title: website,
                style: .default,
                handler: openPage
            ))
        }
        
        ac.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel
        ))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage( action: UIAlertAction ){
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webIsBlocked() {
        let alertController = UIAlertController(
            title: "site is blocked",
            message: nil,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel
        ))
        
        present(alertController, animated: true)
    }
    

}
