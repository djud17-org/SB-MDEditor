//
//  CreateDocInteractor.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 02.05.2023.
//

import Foundation

protocol ICreateDocInteractor {

	/// Подготовить данные для вью.
	func viewIsReady()
	/// Вернуться на уровень выше.
	func backToPreviousPath()
}

final class CreateDocInteractor: ICreateDocInteractor {
	private let presenter: ICreateDocPresenter
	private let localFiles: ILocalFilesProvider
	private var initialFile: File

	init(
		presenter: ICreateDocPresenter,
		dep: ICreateDocModuleDependency,
		initialFile: File
	) {
		self.presenter = presenter
		self.localFiles = dep.localFiles
		self.initialFile = initialFile
	}

	func viewIsReady() {
		let response = CreateDocModel.Response(
			file: initialFile,
			fileContents: localFiles.readFileAtPath(initialFile.fullname) ?? ""
		)
		presenter.present(response: response)
	}

	func backToPreviousPath() {
		let path = initialFile.path
		let isRoot = initialFile.fullname == path

		let file = File.makePrototypeDir()
		if !isRoot {
			file.name = (path as NSString).lastPathComponent
			file.path = (path as NSString).deletingLastPathComponent
		}

		presenter.transit(with: .backDir(file))
	}
}
