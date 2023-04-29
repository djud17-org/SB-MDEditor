//
//  AboutInteractor.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 26.04.2023.
//

import UIKit

protocol IBusinessLogic {

	/// Функция осуществляет чтение данных для отображения на экране контроллера.
	func readFileContents()
}

final class AboutInteractor: IBusinessLogic {

	// MARK: Parameters
	private let presenter: IPresentationLogic

	init(presenter: IPresentationLogic) {
		self.presenter = presenter
	}

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
		static let aboutFilePath = Bundle.main.resourcePath! + "/About.md" // swiftlint:disable:this force_unwrapping
	}
}
