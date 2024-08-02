//
//  ViewController.swift
//  Project-4
//
//  Created by Kevin Cuadros on 2/08/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
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
        
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func opentapped() {
        let ac = UIAlertController(
            title: "Open page...",
            message: nil,
            preferredStyle: .actionSheet
        )
        ac.addAction(UIAlertAction(
            title: "apple.com",
            style: .default,
            handler: openPage
        ))
        ac.addAction(UIAlertAction(
            title: "kevincuadros.com",
            style: .default,
            handler: openPage
        ))
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
    

}

