//
//  OpenDocInteractor.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import Foundation

protocol IOpenDocInteractor {
	func viewIsReady()
	func didFileSelected(at indexPath: IndexPath)
}

protocol IOpenDocDataStore {
	// var name: String { get set }
}

final class OpenDocInteractor: IOpenDocInteractor {
	private let presenter: IOpenDocPresenter?
	private let localFiles: ILocalFilesProvider

	init(presenter: IOpenDocPresenter, dep: IOpenModuleDocDependency) {
		self.presenter = presenter
		self.localFiles = dep.localFiles
	}

	func viewIsReady() {
		let response = OpenDocModel.Something.Response(files: localFiles.getFiles())
		presenter?.present(response: response)
		print(localFiles.getPath())
	}

	func didFileSelected(at indexPath: IndexPath) {
		let files = localFiles.getFiles()
		let file = files[indexPath.row]

		setPath(with: file.path)

		if file.filetype == File.FileType.file {
			print("Select \(file.fullname)")
		} else {
			viewIsReady()
		}
	}

	private func setPath(with path: String) {
		_ = localFiles.setPath(path)
	}
}
