//
//  MDView.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 20.04.2023.
//

import UIKit

struct MDViewData {
	let image: UIImage
	let message: String
}

extension MDViewData {
	static let EmptyViewData = MDViewData(
		image: UIImage(asset: Asset.Placeholders.emptyPlaceholder),
		message: "Empty folder"
	)

	static let ResentFileData = MDViewData(
		image: UIImage(asset: Asset.Placeholders.recentFilesPlaceholder),
		message: "No recent file"
	)
}
