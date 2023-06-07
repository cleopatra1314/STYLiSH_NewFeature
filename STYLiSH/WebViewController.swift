//
//  WebViewController.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/7.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: STBaseViewController {
    
    var webView: WKWebView!
    
    let socket = WebSocket.shared
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://0tlh7m.csb.app/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        if #available(iOS 14.0, *) {
            let dismiss = UIAction { [weak self] _ in
                self?.socket.socketEmit(with: "Test from iPhone!")
                //self?.dismiss(animated: true)
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: dismiss)
            navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self] _ in
                self?.socket.socketEmitFromAdmin()
            }))
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
        
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
}
