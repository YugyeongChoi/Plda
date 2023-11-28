//
//  ImageViewModel.swift
//  Plda mini
//
//  Created by 최유경 on 11/28/23.
//

import Foundation
import UIKit

class ViewController : UIViewController {
    @IBOutlet weak var image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://i.ytimg.com/vi/kMRLzSQorK0/hqdefault.jpg")
        image.load(url: url!)
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
