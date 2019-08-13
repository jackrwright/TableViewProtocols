//
//  DeletableCell.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

protocol DeletableCellModelDelegate {

	func deleteRowAtIndexPath(_ indexPath: IndexPath)
}

class DeletableCellModel: TableViewCompatible {
	
	var reuseIdentifier: String {
		return "DeletableCellID"
	}
	
	var title: String
	var canDelete: Bool = false
	var delegate: DeletableCellModelDelegate?

	init(title: String, delegate: DeletableCellModelDelegate? = nil) {
		self.title = title
		self.delegate = delegate
		self.canDelete = delegate != nil
	}

	func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! DeletableTableViewCell
		
		cell.configureWithModel(self)

		return cell
	}

	func commit(editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		if editingStyle == .delete {
			
			self.delegate?.deleteRowAtIndexPath(indexPath)
		}
	}
}

class DeletableTableViewCell: UITableViewCell, Configurable {
	
	@IBOutlet weak var titleLabel: UILabel!
	
	var model: DeletableCellModel?
	
	func configureWithModel(_ model: DeletableCellModel) {
		
		self.model = model
		self.titleLabel.text = model.title
	}
}
