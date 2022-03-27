//
//  MenuDetailViewController.swift
//  SampleBook
//
//  Created by eriko on 2022/03/27.
//

import UIKit

class MenuDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var info: Menu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = info.name
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        thumbnailImage.image = UIImage(named: info.imgName)
    }
}
