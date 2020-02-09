//
//  HitsTableViewCell.swift
//  ProtonsHubTestAssignment
//
//  Created by Bushra on 09/02/20.
//  Copyright © 2020 Softinator. All rights reserved.
//

import UIKit
protocol CellDelegate: class {
    func reloadTitle()
}

class HitsTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var createdAt: UILabel!
    @IBOutlet var `switch`: UISwitch!
    weak var delegate: CellDelegate?

    var setSelected = false
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        setSelected = sender.isOn
        delegate?.reloadTitle()
    }
    
    func doSelection(_ value: Bool) {
        DispatchQueue.main.async{
            self.switch.isOn = value
        }
        self.setSelected = value
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.switch.isOn = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
