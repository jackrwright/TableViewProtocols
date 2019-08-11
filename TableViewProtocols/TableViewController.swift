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
	
	private var tableViewSections = [
		
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
	]
	
	// MARK: - view controler life-cycle
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		myDataSource.sections = tableViewSections
		
		tableView.dataSource = myDataSource
		
		tableView.reloadData()
	}
}
