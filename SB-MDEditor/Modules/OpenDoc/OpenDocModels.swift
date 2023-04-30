//
//  OpenDocModels.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

enum OpenDocModel {
	struct Response {
		let file: File
		let files: [File]
	}

	struct ViewData {
		struct FileViewModel {
			let name: String
			let fileAttributes: String
			let fileImage: UIImage
		}

		let title: String
		let hasPreviousPath: Bool
		let files: [FileViewModel]
	}

	enum ViewModel {
		case openFile(File)
		case showDir(ViewData)
		case openDir(File)
		case backDir(File)
	}
}
