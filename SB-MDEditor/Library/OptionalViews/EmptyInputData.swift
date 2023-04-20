//
//  EmptyInputData.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 20.04.2023.
//

import UIKit

struct EmptyInputData {
	let image: UIImage
	let message: String
}

extension EmptyInputData {
	static let emptyFolder = EmptyInputData(
		image: UIImage(asset: Asset.Placeholders.emptyPlaceholder),
		message: "Empty folder"
	)

	static let noResentFiles = EmptyInputData(
		image: UIImage(asset: Asset.Placeholders.recentFilesPlaceholder),
		message: "No recent file"
	)
}
