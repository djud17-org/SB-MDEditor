import UIKit

final class Di {
	weak var rootVC: IRootViewController?
	// MARK: - глобальные сервисы-зависимости
	private let storage: UserDefaults
	private var dependencies: AllDependencies! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - инициализация глобальных сервисов
	init(
		rootVC: IRootViewController,
		storage: UserDefaults = .standard
	) {
		self.rootVC = rootVC
		self.storage = storage

		dependencies = Dependency(
			storage: makeFilesStorageProvider(storage)
		)
	}

	struct Dependency: AllDependencies {
		let storage: IFilesStorageProvider
	}
}

// MARK: - Module Dependency

protocol IMainModuleDepencency {
	var storage: IFilesStorageProvider { get }
}
protocol IOpenModuleDocDepencency {
	var storage: IFilesStorageProvider { get }
}
protocol ICreateModuleDocDepencency {
	var storage: IFilesStorageProvider { get }
}
protocol IAboutModuleDepencency {
	var storage: IFilesStorageProvider { get }
}

typealias AllDependencies = (
	IMainModuleDepencency &
	IOpenModuleDocDepencency &
	ICreateModuleDocDepencency &
	IAboutModuleDepencency
)
