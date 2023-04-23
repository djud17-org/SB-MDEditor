import Foundation

// MARK: - ServicesFactory

protocol ServicesFactory {
	func makeFilesStorageProvider(_ storage: UserDefaults) -> IFilesStorageProvider
}

extension Di: ServicesFactory {
	func makeFilesStorageProvider(_ storage: UserDefaults) -> IFilesStorageProvider {
		FilesStorageProvider(userDefaults: storage)
	}
}
