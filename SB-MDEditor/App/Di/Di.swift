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
protocol IAboutModuleDepencency {}

typealias AllDependencies = (
	IMainModuleDepencency &
	IOpenModuleDocDepencency &
	ICreateModuleDocDepencency &
	IAboutModuleDepencency
)

// MARK: - ModuleFactory

extension Di: ModuleFactory {
	func makeStartModule() -> Module {
		makeAboutModule()
	}

	func makeAboutModule() -> Module {
		let presenter = AboutPresenter()
		let interactor = AboutInteractor(presenter: presenter)
		let router = AboutRouter()
		let viewController = AboutViewController(
			interactor: interactor,
			router: router
		)

		presenter.viewController = viewController

		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true
		return .init(viewController: navigationVC, animatedType: .fade)
	}

	func makeMainModule() -> Module {
		let presenter = MainPresenter()
		let worker = MainWorker()
		let interactor = MainInteractor(presenter: presenter, worker: worker)
		let router = MainRouter()
		let sectionManager = SectionManager()
		let viewController = MainViewController(
			interactor: interactor,
			router: router,
			sectionManager: sectionManager
		)

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
