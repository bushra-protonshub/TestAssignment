//
//  ViewController.swift
//  ProtonsHubTestAssignment
//
//  Created by Bushra on 09/02/20.
//  Copyright © 2020 Softinator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewModel = HitsViewModel()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var refreshLabel: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching More Data ...")
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(self.refreshControl)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        viewModel.delegate = self
        viewModel.getHits()
        setNavigationTitle()
    }

    func setNavigationTitle() {
        var selectedCells = 0
        for i in 0..<viewModel.hits.count {
            let cell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0))
            if let cell = cell as? HitsTableViewCell {
                if cell.setSelected {
                    selectedCells = selectedCells + 1
                }
            }
        }
        DispatchQueue.main.async {
            self.navigationItem.title = "\(selectedCells) Hits selected"
        }
    }
    
    @objc func reloadTitle(sender: UISwitch) {
        self.setNavigationTitle()
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshLabel.isHidden = true
        WebServiceHandler.indexOfPageToRequest = +1
        viewModel.getHits()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        refreshLabel.isHidden = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hit = viewModel.hits[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HitsTableViewCell") as? HitsTableViewCell
        if let cell = cell {
            cell.title.text = hit.title
            cell.createdAt.text = hit.created_at
            cell.switch.addTarget(self, action: #selector(reloadTitle(sender:)), for: .touchUpInside)
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? HitsTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        cell?.doSelection(!(cell?.setSelected ?? false))
        setNavigationTitle()
    }

}

extension ViewController: ViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
