//
//  BasicCell.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

/// - Tag: TableViewCompatible

class BasicCellModel: TableViewCompatible {
	
	var reuseIdentifier: String {
		return "BasicCellID"
	}
	
	var title: String
	
	init(title: String) {
		self.title = title
	}

	func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! BasicTableViewCell
		
		cell.configureWithModel(self)

		return cell
	}
}

class BasicTableViewCell: UITableViewCell, Configurable {
	
	@IBOutlet weak var titleLabel: UILabel!
	
	var model: BasicCellModel?
	
	func configureWithModel(_ model: BasicCellModel) {
		
		self.model = model
		self.titleLabel.text = model.title
	}
}
