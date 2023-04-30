import UIKit

final class Di {
	weak var rootVC: IRootViewController?
	// MARK: - глобальные сервисы-зависимости

	private var dependencies: AllDependencies! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - инициализация глобальных сервисов
	init(rootVC: IRootViewController) {
		self.rootVC = rootVC

		let filesStorageProvider = makeFilesStorageProvider()

		dependencies = Dependency(
			storage: filesStorageProvider,
			localFiles: makeLocalFilesProvider(filesStorageProvider),
			sectionManager: SectionManager()
		)
	}

	struct Dependency: AllDependencies {
		let storage: IFilesStorageProvider
		let localFiles: ILocalFilesProvider
		let sectionManager: ISectionManager
	}
}

// MARK: - Module Dependency

protocol IMainModuleDependency {
	var storage: IFilesStorageProvider { get }
	var sectionManager: ISectionManager { get }
}
protocol IOpenModuleDocDependency {
	var storage: IFilesStorageProvider { get }
	var localFiles: ILocalFilesProvider { get }
}
protocol ICreateModuleDocDependency {
	var storage: IFilesStorageProvider { get }
}
protocol IAboutModuleDependency {}

typealias AllDependencies = (
	IMainModuleDependency &
	IOpenModuleDocDependency &
	ICreateModuleDocDependency &
	IAboutModuleDependency
)

// MARK: - ModuleFactory

extension Di: ModuleFactory {
	func makeStartModule() -> Module {
		makeOpenDocModule(file: File.makePrototypeDir())
	}

	func makeAboutModule() -> Module {
		makeAboutModule(dep: dependencies)
	}

	func makeMainModule() -> Module {
		makeMainModule(dep: dependencies)
	}

	func makeOpenDocModule(file: File) -> Module {
		makeOpenDocModule(file: file, dep: dependencies)
	}

	func makeCreateDocModule() -> Module {
		makeCreateDocModule(dep: dependencies)
	}
}
