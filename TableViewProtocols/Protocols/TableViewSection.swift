//
//  TableViewSection.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import Foundation

protocol TableViewSection {
	
	var items: [TableViewCompatible] { get set }
	var headerTitle: String? { get set }
	var footerTitle: String? { get set }
	var headerViewId: String? { get set }
	var footerViewId: String? { get set }

	init(items: [TableViewCompatible], headerTitle: String?, footerTitle: String?, headerViewId: String?, footerViewId: String?)
}
