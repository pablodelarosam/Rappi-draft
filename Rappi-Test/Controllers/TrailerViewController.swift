//
//  TrailerViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/28/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    var idMedia: Int?
    var typeMedia: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red 

        // Do any additional setup after loading the view.
        getVideos()
      
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    private func setupWebView(key: String) {
        let url = URL(string: "http://www.youtube.com/watch?v=\(key)")
        
        let request = URLRequest(url: url!)
        
        webView?.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func getVideos() {
        if let id = idMedia, let type = typeMedia {
                 NetworkClient.sharedInstace.getMediaVideos(idMedia: id , typeMedia: type) { (videos) in
                    print(videos)
                    
                    DispatchQueue.main.async {
                        if let key = videos[0].key {
                            self.setupWebView(key: key)
                        }
                        
                    }
        }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
