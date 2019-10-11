//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mercuryObjects: [MercuryObject] = []
    let objectFetcher = MercuryObjectFetcher()
    let imageFetcher = ImageFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        objectFetcher.getData { (objects) in
            self.mercuryObjects = objects
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mercuryObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //this is what is called when the table view wants a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell")
        if let imgCell = cell as? ImageCell {
            imageFetcher.getImage(urlString: mercuryObjects[indexPath.item].url) { (image, url) in
                DispatchQueue.main.async{
                    imgCell.imageHolder.image = image //set cell's image view to the image I just got
                    imgCell.leftLabel.text = self.mercuryObjects[indexPath.item].name
                    imgCell.rightLabel.text = self.mercuryObjects[indexPath.item].type
                }
            }
        }
        return cell!
    }
}
