//
//  HitsViewModel.swift
//  ProtonsHubTestAssignment
//
//  Created by Bushra on 09/02/20.
//  Copyright © 2020 Softinator. All rights reserved.
//

import UIKit
protocol ViewModelDelegate: class {
    func reloadTable()
}

class HitsViewModel {
    var hits: [Hits] = []
    weak var delegate: ViewModelDelegate?
    
    func getHits() {
        WebServiceHandler.getHits { [weak self](hits) in
            if let hits_ = hits {
                for i in hits_ {
                    self?.hits.append(i)
                }
                self?.delegate?.reloadTable()
            }
        }
    }
}
