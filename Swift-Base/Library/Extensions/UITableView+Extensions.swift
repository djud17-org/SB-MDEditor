import UIKit

extension UITableView {
	func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
		let indetifier = String(describing: type(of: model).cellAnyType)
		let cell = self.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)

		model.setupAny(cell: cell)
		return cell
	}

	func register(models: [CellViewAnyModel.Type]) {
		for model in models {
			let identifier = String(describing: model.cellAnyType)
			self.register(model.cellAnyType, forCellReuseIdentifier: identifier)
		}
	}
}
