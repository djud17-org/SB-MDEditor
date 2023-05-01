//
//  AboutInteractor.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 01.05.2023.
//

import UIKit

protocol IAboutInteractor {
	/// Возвращает строковые данные из файла, указанного в константах
	func viewIsReady()
}

final class AboutInteractor: IAboutInteractor {

	// MARK: Parameters
	private let presenter: IAboutPresenter
	private let localFiles: ILocalFilesProvider

	init(
		presenter: IAboutPresenter,
		dep: IAboutModuleDependency
	) {
		self.presenter = presenter
		self.localFiles = dep.localFiles
	}

	func viewIsReady() {
		if let aboutFileText = localFiles.readFileAtPath(Theme.Constansts.aboutFilePath) {
			presenter.present(text: aboutFileText)
		}
	}
}
