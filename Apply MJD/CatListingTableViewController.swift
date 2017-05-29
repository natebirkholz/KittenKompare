//
//  CatListingTableViewController.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import UIKit
import DataManager

class CatListingTableViewController: UITableViewController {

    fileprivate let kittyCell = "kittyCell"

    @IBOutlet var table: UITableView!
    
    var data: [Cat] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient.getCats { (maybeCats, maybeError) in
            guard maybeError == nil else {
                //handle error
                print(maybeError?.description as Any)
                return
            }

            if let cats = maybeCats {
                for cat in cats { self.data.append(cat) }
                self.table.reloadData()
                // Was trying to set itself offscreen slightly, fixed by adding 1
                let topPoint = CGPoint(x: 0, y: 0 - self.table.contentInset.top + 1)
                self.table.setContentOffset(topPoint, animated: true)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: kittyCell, for: indexPath) as! KittyTableViewCell

        let currentTag = cell.tag + 1
        cell.tag = currentTag
        cell.catName.text = data[indexPath.row].name ?? "Mystery cat!"
        cell.caption.text = data[indexPath.row].caption ?? ""
        
        if let catImage = data[indexPath.row].image {
            cell.catImage.image = catImage
        } else {
            if let urlString = data[indexPath.row].imageURL, let urlForImage = URL(string: urlString) {
                APIClient.loadImage(url: urlForImage, completion: { [weak self] (maybeImage, maybeError) in
                    guard maybeError == nil else {
                        // handle error
                        print(maybeError?.description as Any)
                        return
                    }

                    if let imageForCat = maybeImage {
                        cell.catImage.image = imageForCat
                        self?.data[indexPath.row].image = imageForCat
                    }
                })
            }
        }
        
        return cell
    }
    
    
}
