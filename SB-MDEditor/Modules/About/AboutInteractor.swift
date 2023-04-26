//
//  AboutInteractor.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 26.04.2023.
//

import UIKit

protocol AboutBusinessLogic {
	func readFileContents()
}

final class AboutInteractor: AboutBusinessLogic, MainDataStore {
	private let presenter: AboutPresentationLogic

	init(presenter: AboutPresentationLogic) {
		self.presenter = presenter
	}

	// MARK: Do something

	func readFileContents() {
		let fileManager = FileManager.default
		if let aboutFileData = fileManager.contents(atPath: Appearance.aboutFilePath) {
			//		worker.doSomeWork()

			//		let response = Main.Something.Response()
			//		presenter.presentSomething(response: response)
		}
	}
}

// MARK: - Appearance
private extension AboutInteractor {
	enum Appearance {
		static let aboutFilePath = Bundle.main.resourcePath! + "/About.md"
	}
}
