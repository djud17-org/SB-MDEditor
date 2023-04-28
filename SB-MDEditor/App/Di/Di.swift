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
			localFiles: makeLocalFilesProvider(filesStorageProvider)
		)
	}

	struct Dependency: AllDependencies {
		let storage: IFilesStorageProvider
		let localFiles: ILocalFilesProvider
	}
}

// MARK: - Module Dependency

protocol IMainModuleDependency {
	var storage: IFilesStorageProvider { get }
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
		makeMainModule()
	}

	func makeAboutModule() -> Module {
		let viewController = AboutViewController()
		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true
		return .init(viewController: navigationVC, animatedType: .fade)
	}

	func makeMainModule() -> Module {
		let presenter = MainPresenter()
		let worker = MainWorker()
		let interactor = MainInteractor(presenter: presenter, worker: worker)
		let router = MainRouter()
		let viewController = MainViewController(interactor: interactor, router: router, dep: dependencies)

		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true

		return .init(viewController: navigationVC)
	}

	func makeOpenDocModule() -> Module {
		let viewController = OpenDocViewController()
		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.isHidden = true
		return .init(viewController: navigationVC, animatedType: .dismiss)
	}

	func makeCreateDocModule() -> Module {
		let viewController = CreateDocViewController()
		return .init(viewController: viewController, animatedType: .fade)
	}
}
