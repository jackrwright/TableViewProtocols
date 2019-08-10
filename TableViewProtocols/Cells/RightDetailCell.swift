//
//  RightDetailCell.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

class RightDetailCellModel: TableViewCompatible {
	
	var reuseIdentifier: String {
		return "RightDetailCellID"
	}
	
	var title: String
	var detail: String
	
	init(title: String, detail: String) {
		self.title = title
		self.detail = detail
	}

	func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! RightDetailTableViewCell
		
		cell.configureWithModel(self)

		return cell
	}
}

class RightDetailTableViewCell: UITableViewCell, Configurable {
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	
	var model: RightDetailCellModel?
	
	func configureWithModel(_ model: RightDetailCellModel) {
		
		self.model = model
		self.title.text = model.title
		self.detailLabel.text = model.detail
	}
}
