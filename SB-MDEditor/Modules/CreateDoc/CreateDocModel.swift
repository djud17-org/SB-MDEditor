//
//  CreateDocModel.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 02.05.2023.
//

import UIKit

enum CreateDocModel {
	struct Response {
		let file: File
		let fileContents: String
	}

	struct ViewData {
		let title: String
		let fileContents: String
		let hasPreviousPath: Bool
	}

	enum ViewModel {
		case saveFile(File)
		case backDir(File)
		case showFile(ViewData)
	}
}