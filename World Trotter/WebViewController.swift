//
//  WebViewController.swift
//  World Trotter
//
//  Created by Gina Sprint on 6/18/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://developer.apple.com/documentation/webkit/wkwebview?changes=_8
        let url = URL(string: "https://bignerdranch.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        
        view = webView
        
    }
}
