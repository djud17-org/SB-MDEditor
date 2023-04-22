import UIKit

protocol IFilesStorageProvider {
	/// Путь до фалов бандла.
	var bandlePath: String { get }

	/// Путь до файла с описание приложения.
	var aboutPath: String { get }

	/// Путь до файлов для текущего экрана Открыть документ.
	var currentPath: String? { get set }

	/// Удаляет путь для экрана Открыть документ.
	func removeCurrentPath()

	/// Возвращает список имен недавно открытых файлов.
	/// - Returns: список имен недавно открытых файлов.
	func getRecentFiles() -> [String]

	/// Добавить имя в список недавно открытых файлов.
	/// - Parameter fileName: имя файла
	mutating func add(fileName: String)
}

extension IFilesStorageProvider {
	var currentPathKey: String {
		"currentPath"
	}
	var recentFilesKey: String {
		"recentFiles"
	}
}

struct FilesStorageProvider: IFilesStorageProvider {
	private let userDefaults: UserDefaults
	let bandlePath: String
	let aboutPath: String
	private let capacity: Int

	private var fileNames = [String]()
	var currentPath: String? {
		get {
			userDefaults.string(forKey: currentPathKey)
		}

		set {
			guard let newValue = newValue else {
				userDefaults.removeObject(forKey: currentPathKey)
				return
			}
			userDefaults.set(newValue, forKey: currentPathKey)
		}
	}

	init(
		userDefaults: UserDefaults,
		bandlePath: String,
		aboutPath: String,
		capacity: Int = 5
	) {
		self.userDefaults = userDefaults
		self.bandlePath = bandlePath
		self.aboutPath = aboutPath
		self.capacity = capacity
		fileNames = userDefaults.stringArray(forKey: recentFilesKey) ?? [String]()
	}

	// MARK: - Public methods

	func removeCurrentPath() {
		userDefaults.removeObject(forKey: currentPathKey)
	}

	func getRecentFiles() -> [String] {
		fileNames
	}

	mutating func add(fileName: String) {
		guard fileNames.contains(fileName) == false else { return }

		fileNames.insert(fileName, at: 0)
		if fileNames.count > capacity {
			fileNames.removeLast()
		}

		userDefaults.set(fileNames, forKey: recentFilesKey)
	}
}
