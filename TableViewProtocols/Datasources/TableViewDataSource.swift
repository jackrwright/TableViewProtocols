//
//  TableViewDataSource.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {
	
	var sections = [TableViewSection]()
	
	var sectionIndexTitles: [String]?
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].items.count
	}
	
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return sectionIndexTitles
	}
	
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach {
			if $0.section < sections.count, $0.row < sections[$0.section].items.count {
				indexPaths.forEach { sections[$0.section].items[$0.row].prefetch?() }
			}
		}
	}
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach {
			if $0.section < sections.count, $0.row < sections[$0.section].items.count {
				sections[$0.section].items[$0.row].cancelPrefetch?()
			}
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = sections[indexPath.section].items[indexPath.row]
		return model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let title = sections[section].headerViewId == nil ? sections[section].headerTitle : nil
		return title
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		let title = sections[section].footerViewId == nil ? sections[section].footerTitle : nil
		return title
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		let model = sections[indexPath.section].items[indexPath.row]
		model.commit?(editingStyle: editingStyle, forRowAt: indexPath)
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return sections[indexPath.section].items[indexPath.row].canDelete ?? false
	}
}
