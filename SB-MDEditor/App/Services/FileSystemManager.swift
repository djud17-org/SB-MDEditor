//
//  FileManager.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 24.04.2023.
//

import Foundation

protocol IFileSystemManager {
	/// Возвращает список файлов по переданному url
	/// - Parameter fileUrl: url для отображения списка
	/// - Returns: Список файлов
	func getFileList(for fileUrl: String) -> [String]

	/// Возвращает содержимое файла по переданному url
	/// - Parameter fileUrl: url файла
	/// - Returns: Содержимое файла
	func getFileContent(for fileUrl: String) -> String?

	/// Возвращает файл
	/// - Parameters:
	///   - fileName: Имя файла
	///   - atPath: url файла
	/// - Returns: Файл
	func getFile(for fileName: String, atPath: String) -> File?
}

final class FileSystemManager: IFileSystemManager {
	private let fileStorage: IFilesStorageProvider
	private let fileManager = FileManager.default

	init(fileStorage: IFilesStorageProvider) {
		self.fileStorage = fileStorage
	}

	func getFileList(for fileUrl: String) -> [String] {
		guard fileManager.fileExists(atPath: fileUrl) else { return [] }

		do {
			let files = try fileManager.contentsOfDirectory(atPath: fileUrl)
			return files
		} catch {
			print("Невозможно найти файлы")
		}

		return []
	}

	func getFileContent(for fileUrl: String) -> String? {
		guard fileManager.fileExists(atPath: fileUrl),
			  let fileUrl = URL(string: fileUrl) else { return nil }

		do {
			let data = try Data(contentsOf: fileUrl)
			let content = String(data: data, encoding: .utf8)

			return content
		} catch {
			print("Невозможно прочитать файл")
		}

		return nil
	}

	func getFile(for fileName: String, atPath: String) -> File? {
		guard let resourcePath = Bundle.main.resourcePath else { return nil }

		let fullPath = resourcePath + "/\(atPath)"
		do {
			let attributes = try fileManager.attributesOfItem(atPath: fullPath + "/" + fileName)

			let fileType: File.FileType
			if let type = attributes[FileAttributeKey.type] as? FileAttributeType,
			   type == FileAttributeType.typeDirectory {
				fileType = .directory
			} else {
				fileType = .file
			}
			let fileSize = (attributes[FileAttributeKey.size] as? UInt64) ?? 0
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

			let ext = fileType == .directory
			? ""
			: String(describing: fileName.split(separator: ".").last)

			let file = File(
				name: fileName,
				path: atPath,
				ext: ext,
				size: fileSize,
				filetype: fileType,
				creationDate: creationDate,
				modificationDate: modificationDate
			)

			return file
		} catch {
			print("Невозможно найти файл")
		}

		return nil
	}
}
