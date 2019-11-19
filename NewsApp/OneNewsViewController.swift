//
//  OneNewsViewController.swift
//  NewsApp
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Artem Ulko. All rights reserved.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {
    
    var article: Article!
    var index: Int = 0

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesciption: UILabel!
    @IBOutlet weak var pushOpenOutlet: UIButton!
    
    @IBAction func pushOpenAction(_ sender: UIButton) {
        
        if let url = URL(string: article.url) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = article.title
        labelDesciption.text = article.description
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage) {
                if let data = try? Data(contentsOf:url) {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        if URL(string: article.url) == nil {
            pushOpenOutlet.isEnabled = false
        }
    }
    
}
