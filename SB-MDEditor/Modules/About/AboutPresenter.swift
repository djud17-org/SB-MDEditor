//
//  AboutPresenter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 01.05.2023.
//

import UIKit

protocol IAboutPresenter {
	/// Подготавливает данные на редринг вьюконтроллеру
	func present(text: String)
}

final class AboutPresenter: IAboutPresenter {
	// MARK: Parameters

	weak var viewController: IAboutViewController?

	func present(text: String) {
		let viewData = AboutModel.ViewData(fileContents: text)
		viewController?.render(viewModel: viewData)
	}
}
