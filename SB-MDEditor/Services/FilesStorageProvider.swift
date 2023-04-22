import UIKit

protocol IFilesStorageProvider {
	var bandlePath: String { get }
	var aboutPath: String { get }
	var currentPath: String? { get set }
	func removeCurrentPath()
	func getRecentFiles() -> [String]
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
