//
//  AboutPresenter.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 26.04.2023.
//

import UIKit

protocol AboutPresentationLogic {
	func presentSomething(response: Main.Something.Response)
}

final class AboutPresenter: AboutPresentationLogic {
//	weak var viewController: MainDisplayLogic?

	// MARK: Do something

	func presentSomething(response: Main.Something.Response) {
		let viewModel = Main.Something.ViewModel()
//		viewController?.displaySomething(viewModel: viewModel)
	}
}
