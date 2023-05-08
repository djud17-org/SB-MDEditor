//
//  OpenDocInteractor.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import Foundation

protocol IOpenDocInteractor {

	/// Подготовить данные для вью.
	func viewIsReady()
	/// Обработать выбранный файл: показать содержимое файла или каталога.
	func didFileSelected(at indexPath: IndexPath)
	/// Вернуться на каталог выше.
	func backToPreviousPath()
	/// Создать новый файл в текущей директории.
	func didTapCreateFile()
	/// Создать новый каталог в текущей диерктории.
	func didTapCreateDir()
}

final class OpenDocInteractor: IOpenDocInteractor {
	private let presenter: IOpenDocPresenter?
	private let localFiles: ILocalFilesProvider
	private var initialFile: File

	init(
		presenter: IOpenDocPresenter,
		dep: IOpenDocModuleDependency,
		initialFile: File
	) {
		self.presenter = presenter
		self.localFiles = dep.localFiles
		self.initialFile = initialFile
	}

	func viewIsReady() {
		let currentPath = localFiles.setPath(initialFile.fullname)
		if currentPath.isEmpty {
			initialFile = File.makePrototypeDir()
		}

		let response = OpenDocModel.Response(
			file: initialFile,
			files: localFiles.getFiles()
		)
		presenter?.present(response: response)
	}

	func didFileSelected(at indexPath: IndexPath) {
		// TODO: - здесь надо делать проверку - файла может уже не быть
		let files = localFiles.getFiles()
		let file = files[indexPath.row]

		switch file.filetype {
		case .directory:
			presenter?.transit(with: .openDir(file))
		case .file:
			presenter?.transit(with: .openFile(file))
		}
	}

	func didTapCreateFile() {
		presenter?.transit(with: .createFile(initialFile))
	}

	func didTapCreateDir() {
		presenter?.transit(with: .createDir(initialFile))
	}

	func backToPreviousPath() {
		let path = initialFile.path
		let isRoot = initialFile.fullname == path

		let file = File.makePrototypeDir()
		if !isRoot {
			file.name = (path as NSString).lastPathComponent
			file.path = (path as NSString).deletingLastPathComponent
		}

		presenter?.transit(with: .openDir(file))
	}
}
