//
//  OpenDocModels.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

enum OpenDocModel {
	// MARK: Use cases

	enum Something {
		struct Request {}

		struct Response {
			let files: [File]
		}

		struct ViewModel {
			struct FileViewModel {
				let name: String
				let fileAttributes: String
				let fileImage: UIImage
			}

			let files: [FileViewModel]
		}
	}
}
