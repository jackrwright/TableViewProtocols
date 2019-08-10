//
//  TableViewCompatible.swift
//  TableViewProtocols
//
//  Created by Jack Wright on 8/9/19.
//  Copyright © 2019 Jack Wright. All rights reserved.
//

import UIKit

/// A protocol for table view cell models
@objc protocol TableViewCompatible {
	
	var reuseIdentifier: String { get }
	@objc optional var canDelete: Bool { get }
	
	func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
	
	@objc optional func commit(editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
	
	@objc optional func prefetch()
	@objc optional func cancelPrefetch()
}

/// A protocol for use by subclasses of UITableViewCell
protocol Configurable {
	
	associatedtype T
	var model: T? { get set }
	func configureWithModel(_: T)
}
