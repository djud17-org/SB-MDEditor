protocol ICreateDocPresenter {
	/// Подготовить данные к показу на вью.
	func present(response: CreateDocModel.Response)
	/// Передать уже готовые данные вью.
	func transit(with file: CreateDocModel.ViewModel)
}

final class CreateDocPresenter: ICreateDocPresenter {
	weak var viewController: ICreateDocViewController?

	func present(response: CreateDocModel.Response) {
		let viewModel = mapViewModel(data: response)
		viewController?.render(viewModel: viewModel)
	}

	func transit(with file: CreateDocModel.ViewModel) {
		viewController?.render(viewModel: file)
	}
}

// MARK: - Private methods
private extension CreateDocPresenter {
	func mapViewModel(data: CreateDocModel.Response) -> CreateDocModel.ViewModel {

		var title = data.file.name
		if title.isEmpty {
			title = "Untitled"
		}

		return .showFile(
			.init(
				title: title,
				fileContents: data.fileContents,
				hasPreviousPath: !data.file.path.isEmpty
			)
		)
	}
}
