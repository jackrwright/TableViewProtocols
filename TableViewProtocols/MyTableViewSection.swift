//
//  MyTableViewSection.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import Foundation

import Foundation

class MyTableViewSection: TableViewSection {
	
	var items: [TableViewCompatible]
	var headerTitle: String?
	var footerTitle: String?
	var headerViewId: String?
	var footerViewId: String?
	
	required init(items: [TableViewCompatible], headerTitle: String? = nil, footerTitle: String? = nil, headerViewId: String? = nil, footerViewId: String? = nil) {
		self.items = items
		self.headerTitle = headerTitle
		self.footerTitle = footerTitle
		self.headerViewId = headerViewId
		self.footerViewId = footerViewId
	}
}
