import UIKit

final class Di {

	// MARK: - глобальные сервисы-зависимости

	private var dependencies: AllDependencies! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - инициализация глобальных сервисов
	init() {

		let filesStorageProvider = makeFilesStorageProvider()

		dependencies = Dependency(
			storage: filesStorageProvider,
			localFiles: makeLocalFilesProvider(filesStorageProvider)
		)
	}

	struct Dependency: AllDependencies {
		let storage: IFilesStorageProvider
		let localFiles: ILocalFilesProvider
	}
}

// MARK: - Module Dependency

protocol IOpenDocModuleDependency {
	var storage: IFilesStorageProvider { get }
	var localFiles: ILocalFilesProvider { get }
}
protocol ICreateDocModuleDependency {
	var localFiles: ILocalFilesProvider { get }
}
protocol IAboutModuleDependency {
	var localFiles: ILocalFilesProvider { get }
}

typealias AllDependencies = (
	IOpenDocModuleDependency &
	ICreateDocModuleDependency &
	IAboutModuleDependency
)

// MARK: - ModuleFactory

extension Di: ModuleFactory {
	func makeStartModule() -> Module {
		makeMainSimpleModule()
	}

	func makeAboutModule() -> Module {
		makeAboutModule(dep: dependencies)
	}

	func makeOpenDocModule(file: File) -> Module {
		makeOpenDocModule(file: file, dep: dependencies)
	}

	func makeCreateDocModule(file: File) -> Module {
		makeCreateDocModule(file: file, dep: dependencies)
	}

	func makeMainSimpleModule() -> Module {
		makeMainSimpleModule(dep: dependencies)
	}

	func makeOnboardingModule() -> Module {
		makeOnboardingModule(dep: dependencies)
	}
}
