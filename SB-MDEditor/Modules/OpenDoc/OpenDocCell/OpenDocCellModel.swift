//
//  OpenDocCellModel.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

struct OpenDocCellModel {
	let name: String
	let fieldFileAttributes: String
	let fieldImage: UIImage
}

extension OpenDocCellModel: CellViewModel {
	func setup(cell: OpenDocCell) {
		cell.fieldImage.image = fieldImage
		cell.fieldFileName.text = name
		cell.fieldFileAttributes.text = fieldFileAttributes
	}
}
