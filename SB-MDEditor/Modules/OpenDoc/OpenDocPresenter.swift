//
//  OpenDocPresenter.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

protocol IOpenDocPresenter {
	func present(response: OpenDocModel.Response)
	func transit(with file: OpenDocModel.ViewModel)
}

final class OpenDocPresenter: IOpenDocPresenter {
	weak var viewController: IOpenDocViewController?

	func present(response: OpenDocModel.Response) {
		let viewModel = mapViewModel(data: response)
		viewController?.render(viewModel: viewModel)
	}

	func transit(with file: OpenDocModel.ViewModel) {
		viewController?.render(viewModel: file)
	}
}

// MARK: - Private methods
private extension OpenDocPresenter {
	func mapViewModel(data: OpenDocModel.Response) -> OpenDocModel.ViewModel {
		var files: [OpenDocModel.ViewData.FileViewModel] = []

		for file in data.files {
			let fileData = OpenDocModel.ViewData.FileViewModel(
				name: file.name,
				fileAttributes: file.getFormattedAttributes(),
				fileImage: getImage(typeFile: file.filetype)
			)

			files.append(fileData)
		}

		var title = data.file.name
		if title.isEmpty {
			title = "/"
		}

		return .showDir(
			.init(
				title: title,
				hasPreviousPath: !data.file.path.isEmpty,
				files: files
			)
		)
	}

	func getImage(typeFile: File.FileType) -> UIImage {
		switch typeFile {
		case .directory:
			return Asset.icFolder.image
		case .file:
			return Asset.icFile.image
		}
	}
}
