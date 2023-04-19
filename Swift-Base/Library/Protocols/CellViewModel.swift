import UIKit

protocol CellViewAnyModel {
	static var cellAnyType: UIView.Type { get }
	func setupAny(cell: UIView)
}

protocol CellViewModel: CellViewAnyModel {
	associatedtype CellType: UIView
	func setup(cell: CellType)
}

extension CellViewModel {
	static var cellAnyType: UIView.Type {
		return CellType.self
	}

	func setupAny(cell: UIView) {
		if let cell = cell as? CellType {
			setup(cell: cell)
		} else {
			assertionFailure("Wrong usage")
		}
	}
}
