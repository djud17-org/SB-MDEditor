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
		message: Appearance.emptyFolderMessage
	)

	static let noResentFiles = EmptyInputData(
		image: UIImage(asset: Asset.Placeholders.recentFilesPlaceholder),
		message: Appearance.noResentFilesMessage
	)
}

private extension EmptyInputData {
	enum Appearance {
		static let emptyFolderMessage = "Empty folder"
		static let noResentFilesMessage = "No recent files"
	}
}
