import Foundation

// MARK: - ServicesFactory

protocol ServicesFactory {
	func makeFilesStorageProvider(_ storage: UserDefaults) -> IFilesStorageProvider
	func makeLocalFilesProvider(_ storage: IFilesStorageProvider) -> ILocalFilesProvider
}

extension Di: ServicesFactory {
	func makeFilesStorageProvider(_ storage: UserDefaults) -> IFilesStorageProvider {
		FilesStorageProvider(userDefaults: storage)
	}

	func makeLocalFilesProvider(_ storage: IFilesStorageProvider) -> ILocalFilesProvider {
		LocalFilesProvider(
			filesStorage: storage,
			baseFilePaths: Theme.Constansts.baseFilePaths,
			exceptionFiles: [Theme.Constansts.aboutFilePath],
			exts: Theme.Constansts.exts
		)
	}
}
