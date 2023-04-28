import UIKit

protocol IFilesStorageProvider {
	/// Возвращает список имен недавно открытых файлов.
	/// - Returns: список имен недавно открытых файлов.
	func getRecentFiles() -> [String]

	/// Добавить имя в список недавно открытых файлов.
	/// - Parameter fileName: имя файла
	func add(fileName: String)
}

private extension IFilesStorageProvider {
	var recentFilesKey: String {
		"recentFiles"
	}
}

final class FilesStorageProvider {
	private let userDefaults: UserDefaults
	private let capacity: Int

	private var fileNames = [String]()

	init(capacity: Int = 5) {
		userDefaults = UserDefaults.standard
		self.capacity = capacity
		fileNames = userDefaults.stringArray(forKey: recentFilesKey) ?? [String]()
	}
}

// MARK: - IFilesStorageProvider

extension FilesStorageProvider: IFilesStorageProvider {
	func getRecentFiles() -> [String] {
		fileNames
	}

	func add(fileName: String) {
		guard fileNames.contains(fileName) == false else { return }

		fileNames.insert(fileName, at: 0)
		if fileNames.count > capacity {
			fileNames.removeLast()
		}

		userDefaults.set(fileNames, forKey: recentFilesKey)
	}
}
