import Foundation

protocol ILocalFilesProvider {
	/// Возвращает текущий путь к файлам.
	/// - Parameter path: путь который хотим установить.
	/// - Returns: текущий путь, может отличаться от переданного.
	func setPath(_ path: String) -> String

	/// Возвращает строковое содержимое файла, если смогли его получить, иначе nil.
	/// В случае успеха запоминает файл в списке ранее прочитанных.
	/// - Parameter path: путь к файлу.
	/// - Returns: строковое содержимое файла или nil.
	func readFileAtPath(_ path: String) -> String?

	/// Возвращает список файлов по текущему пути.
	/// - Returns: списко файлов.
	func getFiles() -> [File]

	/// Возвращает текущий путь к файлам.
	/// - Returns: текущий путь к файлам.
	func getPath() -> String
}

final class LocalFilesProvider {
	// MARK: - Properties

	private var filesStorage: IFilesStorageProvider

	private let baseFilePaths: [File]
	private let exceptionFiles: [String]
	private let exts: [String]

	private var files = [File]()

	private var currentPath = "" {
		didSet {
			if currentPath.isEmpty {
				files = baseFilePaths
			} else {
				files = getFilesAtCurrentPath()
			}
		}
	}

	private let fileManager = FileManager.default

	// MARK: - Init

	init(
		filesStorage: IFilesStorageProvider,
		baseFilePaths: [File],
		exceptionFiles: [String],
		exts: [String]
	) {
		self.filesStorage = filesStorage
		self.baseFilePaths = baseFilePaths
		self.exceptionFiles = exceptionFiles
		self.exts = exts
		files = baseFilePaths
	}
}

// MARK: - ILocalFilesProvider

extension LocalFilesProvider: ILocalFilesProvider {
	func readFileAtPath(_ path: String) -> String? {
		guard let fileContent = fileManager.contents(atPath: path),
			  let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else { return nil }
		if !exceptionFiles.contains(where: { $0 == path }) {
			filesStorage.add(fileName: path)
		}
		return fileContentEncoded
	}

	func setPath(_ path: String) -> String {
		if checkPath(path) {
			currentPath = path
		} else {
			currentPath = ""
		}

		return currentPath
	}

	func getFiles() -> [File] {
		files
	}

	func getPath() -> String {
		currentPath
	}
}

// MARK: - Private methods
private extension LocalFilesProvider {
	func checkPath(_ path: String) -> Bool {
		for item in baseFilePaths where path.hasPrefix(item.fullname) { return true }
		return false
	}

	func getFilesAtCurrentPath() -> [File] {
		guard let list = try? fileManager.contentsOfDirectory(atPath: currentPath) else { return [] }

		var file: [File] = []
		var directory: [File] = []

		for item in list where !item.hasPrefix(".") {

			guard let fileItem = getFile(withName: item, atPath: currentPath) else { continue }

			switch fileItem.filetype {
			case .file:
				guard exts.contains(where: { $0 == fileItem.ext }) else { continue }
				guard !exceptionFiles.contains(where: { $0 == fileItem.fullname }) else { continue }

				file.append(fileItem)
			case .directory:
				directory.append(fileItem)
			}
		}

		file.sort { $0.name < $1.name }
		directory.sort { $0.name < $1.name }
		return directory + file
	}

	func getFile(withName fileName: String, atPath: String) -> File? {
		do {
			let attributes = try fileManager.attributesOfItem(atPath: atPath + "/" + fileName)

			let fileType: File.FileType
			if let type = attributes[FileAttributeKey.type] as? FileAttributeType,
			   type == FileAttributeType.typeDirectory {
				fileType = .directory
			} else {
				fileType = .file
			}
			let fileSize = (attributes[FileAttributeKey.size] as? UInt64) ?? .zero
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

			let ext = fileType == .directory
			? ""
			: String(describing: fileName.split(separator: ".").last ?? "")

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
			print("Невозможно получить данные о файле")
		}

		return nil
	}
}
