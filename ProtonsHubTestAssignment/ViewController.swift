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
    var cell = HitsTableViewCell()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        viewModel.delegate = self
        cell.delegate = self
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
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? HitsTableViewCell
        cell?.doSelection(!(cell?.setSelected ?? false))
        setNavigationTitle()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.hits.count - 1 {
            WebServiceHandler.indexOfPageToRequest = +1
            viewModel.getHits()
        }
    }
}

extension ViewController: ViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: CellDelegate {
    func reloadTitle() {
        self.setNavigationTitle()
    }
}
