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

	// MARK: Parameters
	private let presenter: AboutPresentationLogic

	// MARK: Init
	init(presenter: AboutPresentationLogic) {
		self.presenter = presenter
	}

	// MARK: Functions
	func readFileContents() {
		let fileManager = FileManager.default
		if let aboutFileData = fileManager.contents(atPath: Appearance.aboutFilePath) {
			presenter.present(data: aboutFileData)
		}
	}
}

// MARK: - Appearance
private extension AboutInteractor {
	enum Appearance {
		static let aboutFilePath = Bundle.main.resourcePath! + "/About.md"
	}
}
