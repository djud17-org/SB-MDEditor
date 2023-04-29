//
//  OpenDocPresenter.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

protocol IOpenDocPresenter {
	func present(response: OpenDocModel.Something.Response)

	func presentNewOpenDocView()
}

final class OpenDocPresenter: IOpenDocPresenter {
	weak var viewController: IOpenDocViewController?

	func present(response: OpenDocModel.Something.Response) {

		let viewModel = mapViewModel(data: response)
		viewController?.render(viewModel: viewModel)
	}

	func presentNewOpenDocView() {
	}

	private func mapViewModel(data: OpenDocModel.Something.Response) -> OpenDocModel.Something.ViewModel {
		var result = [OpenDocModel.Something.ViewModel.FileViewModel]()

		for element in data.files {
			let fileData = OpenDocModel.Something.ViewModel.FileViewModel(
				name: element.name,
				fileAttributes: element.getFormattedAttributes(),
				fileImage: element.filetype == File.FileType.directory ? Asset.icFolder.image : Asset.icFile.image
			)

			result.append(fileData)
		}

		return OpenDocModel.Something.ViewModel(files: result)
	}
}
