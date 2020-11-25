//
//  WebViewController.swift
//  CurrentNews
//
//  Created by Marmago on 24/11/2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var newsURL: URL? = nil
    

    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: newsURL!)
        webView.load(myRequest)
    }
    
}
