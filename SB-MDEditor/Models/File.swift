import Foundation

final class File {
	enum FileType {
		case directory
		case file
	}

	var name: String
	var path: String
	var ext: String
	var size: UInt64
	let filetype: FileType
	let creationDate: Date
	var modificationDate: Date
	var fullname: String {
		if name.hasPrefix("** ") && name.hasSuffix(" **") {
			return "\(path)"
		} else {
			return "\(path)/\(name)"
		}
	}

	init(
		name: String,
		path: String,
		ext: String,
		size: UInt64,
		filetype: FileType,
		creationDate: Date,
		modificationDate: Date
	) {
		self.name = name
		self.path = path
		self.ext = ext
		self.size = size
		self.filetype = filetype
		self.creationDate = creationDate
		self.modificationDate = modificationDate
	}

	/// Возвращает строку с атрибутами файла.
	/// - Returns: отформатированная строка атрибутов файла
	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		switch filetype {
		case .directory:
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		case .file:
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}

	/// Готовит пустое описание для файла-каталога.
	/// - Returns: пустое описание файла-каталога
	static func makePrototypeDir() -> File {
		File(
			name: "",
			path: "",
			ext: "",
			size: .zero,
			filetype: .directory,
			creationDate: Date(),
			modificationDate: Date()
		)
	}

	/// Готовит пустое описание для файла-md.
	/// - Returns: пустое описание файла-md
	static func makePrototypeFile() -> File {
		File(
			name: "Untitled",
			path: "",
			ext: "md",
			size: .zero,
			filetype: .file,
			creationDate: Date(),
			modificationDate: Date()
		)
	}
}

// MARK: - Private methods
private extension File {
	func getFormattedSize() -> String {
		getFormattedSize(with: size)
	}

	func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}
}
