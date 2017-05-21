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

    @IBOutlet var tableVIew: UITableView!
    
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
                self.tableVIew.reloadData()
                // Was trying to set itself offscreen slightly, fixed by adding 1
                let topPoint = CGPoint(x: 0, y: 0 - self.tableVIew.contentInset.top + 1)
                self.tableVIew.setContentOffset(topPoint, animated: true)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableVIew.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: kittyCell, for: indexPath) as! KittyTableViewCell

        let currentTag = cell.tag + 1
        cell.tag = currentTag
        cell.catName.text = data[indexPath.row].name ?? "Mystery cat!"
        cell.caption.text = data[indexPath.row].caption ?? ""
        if let catImage = data[indexPath.row].image { cell.catImage.image = catImage }

        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        return cell
    }
}
