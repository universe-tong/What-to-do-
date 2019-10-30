//
//  TodoCell.swift
//  Todos
//
//  Created by lwnlwn987 on 2019/9/19.
//  Copyright © 2019 刘伟楠. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var checkMark: UILabel!
    @IBOutlet weak var todo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
