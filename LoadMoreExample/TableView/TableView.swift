//
//  TableView.swift
//  LoadMoreExample
//
//  Created by John Codeos on 10/14/2019.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var itemsArray = [String]()

    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //Register Item Cell
        let itemCellNib = UINib(nibName: "TableViewItemCell", bundle: nil)
        self.tableView.register(itemCellNib, forCellReuseIdentifier: "tableviewitemcellid")

        //Register Loading Cell
        let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(loadingCellNib, forCellReuseIdentifier: "loadingcellid")

        loadData()
    }


    func loadData() {
        self.isLoading = false
        for i in 0...40 {
            itemsArray.append("Item \(i)")
        }
        self.tableView.reloadData()
    }


    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            let start = itemsArray.count
            let end = start + 16
            DispatchQueue.global().async {
                // fake background loading task
                sleep(2)
                for i in start...end {
                    self.itemsArray.append("Item \(i)")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemsArray.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewitemcellid", for: indexPath) as! TableViewItemCell
            cell.itemLabel.text = itemsArray[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44 //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
}
