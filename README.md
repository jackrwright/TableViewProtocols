# TableViewProtocols
This project demonstrates the use of Swift Protocols to manage UITableViews with any number of cell types.

This is based on the following work:

[Clean Table View Code Using Swift Protocols](https://blog.jayway.com/2016/11/15/clean-table-view-code-using-swift-protocols/)

I enhanced it to handle support for:
* Custom UITableView headers and footers.
* Prefetching of cells.
* Swipe delete of cells.
* Section titles.

#### Add the following protocol files in your project:
* TableViewCompatible.swift
* TableViewSection.swift

#### The protocols enable us to define a generic UITableView datasource to be added in your project:
* TableViewDataSource.swift

#### For each cell type...
* Define a cell model that conforms to the `TableViewCompatible` protocol.
* Define a UITableViewCell that conforms to the `Configurable` protocol.

For example...

```swift
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
```
[View in Source](https://github.com/jackrwright/TableViewProtocols/blob/master/TableViewProtocols/Cells/BasicCell.swift)

#### Define a class that conforms to the `TableViewSection` protocol...
```swift
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
```
[View in Source](https://github.com/jackrwright/TableViewProtocols/blob/master/TableViewProtocols/MyTableViewSection.swift)

#### Now your Table View Controller can be as simple as:
```swift
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
```
[View in Source](https://github.com/jackrwright/TableViewProtocols/blob/master/TableViewProtocols/TableViewController.swift)

#### To make a cell swipe-deletable, add the `canDelete` var and `func commit(editingStyle:, forRowAt indexPath:)` to the model to initiate the deletion. In the following example, a protocol is defined to perform the deletion from the table, but you can do whatever is appropriate for your app:

```swift
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
```
[View in Source](https://github.com/jackrwright/TableViewProtocols/blob/master/TableViewProtocols/Cells/DeletableCell.swift)

#### The view controller code for adding deletable cells is:

```swift
		MyTableViewSection(items: [
			DeletableCellModel(title: "cell 1 can be deleted", delegate: self),
			DeletableCellModel(title: "cell 2 cannot be deleted"),
			DeletableCellModel(title: "cell 3 can be deleted", delegate: self),
			], headerTitle: "Deletable Cells"),
```

#### And an example of the delegate code is:

```swift
extension TableViewController: DeletableCellModelDelegate {

	func deleteRowAtIndexPath(_ indexPath: IndexPath) {

		self.tableViewSections[indexPath.section].items.remove(at: indexPath.row)

		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
