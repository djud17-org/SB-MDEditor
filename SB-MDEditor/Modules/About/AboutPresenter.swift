//
//  AboutPresenter.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 26.04.2023.
//

import UIKit

protocol AboutPresentationLogic {
	func present(data: Data)
}

final class AboutPresenter: AboutPresentationLogic {

	// MARK: Parameters
	weak var viewController: AboutDisplayLogic?

	// MARK: Functions
	func present(data: Data) {
		guard let textString = String(data: data, encoding: .utf8) else { return }
		viewController?.render(text: textString)
	}
}
