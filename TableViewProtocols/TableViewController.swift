//
//  TableViewController.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/10/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

	// MARK: - Private (properties)
	
	private var myDataSource = TableViewDataSource()
	
	private lazy var tableViewSections = [
		
		MyTableViewSection(items: [
			BasicCellModel(title: "cell 1"),
			BasicCellModel(title: "cell 2"),
			BasicCellModel(title: "cell 3"),
		], headerTitle: "Basic Cells"),
		
		MyTableViewSection(items: [
			RightDetailCellModel(title: "cell", detail: "1"),
			RightDetailCellModel(title: "cell", detail: "2"),
			RightDetailCellModel(title: "cell", detail: "3"),
		], headerTitle: "Right Detail Cells"),
		
		MyTableViewSection(items: [
			DeletableCellModel(title: "cell 1 can be delted", delegate: self),
			DeletableCellModel(title: "cell 2 cannot be deleted"),
			DeletableCellModel(title: "cell 3 can be deleted", delegate: self),
			], headerTitle: "Deletable Cells"),
	]
	
	// MARK: - view controler life-cycle
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		myDataSource.sections = tableViewSections
		
		tableView.dataSource = myDataSource
		
		tableView.reloadData()
	}
}

extension TableViewController: DeletableCellModelDelegate {

	func deleteRowAtIndexPath(_ indexPath: IndexPath) {

		self.tableViewSections[indexPath.section].items.remove(at: indexPath.row)

		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
