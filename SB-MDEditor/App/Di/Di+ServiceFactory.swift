// MARK: - ServicesFactory

protocol ServicesFactory {
	func makeFilesStorageProvider() -> IFilesStorageProvider
	func makeLocalFilesProvider(_ storage: IFilesStorageProvider) -> ILocalFilesProvider
}

extension Di: ServicesFactory {
	func makeFilesStorageProvider() -> IFilesStorageProvider {
		FilesStorageProvider()
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
