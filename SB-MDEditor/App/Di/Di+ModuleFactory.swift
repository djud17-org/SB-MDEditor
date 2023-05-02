import UIKit

// MARK: - Module

enum AnimatedTransitionType {
	case none
	case fade
	case dismiss
}

struct Module {
	let viewController: UIViewController
	var animatedType: AnimatedTransitionType = .none
	var completion: (() -> Void)?

	static let simpleModule = Module(viewController: UIViewController())
}

// MARK: - ModuleFactory

protocol ModuleFactory: AnyObject {
	func makeStartModule() -> Module
	func makeAboutModule() -> Module
	func makeMainModule() -> Module
	func makeOpenDocModule(file: File) -> Module
	func makeCreateDocModule(file: File) -> Module
	func makeMainSimpleModule() -> Module
}

extension Di {
	func makeAboutModule(dep: AllDependencies) -> Module {
		let presenter = AboutPresenter()
		let interactor = AboutInteractor(presenter: presenter, dep: dep)
		let router = AboutRouter()
		let viewController = AboutViewController(
			interactor: interactor,
			router: router
		)

		presenter.viewController = viewController
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true
		return .init(viewController: navigationVC, animatedType: .fade)
	}

	func makeMainModule(dep: AllDependencies) -> Module {
		let presenter = MainPresenter()
		let worker = MainWorker()
		let interactor = MainInteractor(presenter: presenter, worker: worker)
		let router = MainRouter()

		// TODO: - зависимости переданы в VC для тестовых целей, можно оставить так, но не забыть передать нужное interactor
		let viewController = MainViewController(
			interactor: interactor,
			router: router,
			dep: dep
		)

		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true

		return .init(viewController: navigationVC)
	}

	func makeOpenDocModule(file: File, dep: AllDependencies) -> Module {
		let presenter = OpenDocPresenter()
		let interactor = OpenDocInteractor(presenter: presenter, dep: dep, initialFile: file)
		let router = OpenDocRouter()

		let viewController = OpenDocViewController(interactor: interactor, router: router)

		presenter.viewController = viewController
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		return .init(viewController: navigationVC, animatedType: .dismiss)
	}

	func makeCreateDocModule(file: File, dep: AllDependencies) -> Module {
		let presenter = CreateDocPresenter()
		let interactor = CreateDocInteractor(presenter: presenter, dep: dep, initialFile: file)
		let router = CreateDocRouter()

		let viewController = CreateDocViewController(interactor: interactor, router: router)

		presenter.viewController = viewController
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		return .init(viewController: navigationVC, animatedType: .fade)
	}

	func makeMainSimpleModule(dep: AllDependencies) -> Module {
		let router = MainSimpleRouter()
		let viewController = MainSimpleViewController(router: router)
		router.view = rootVC

		let navigationVC = UINavigationController(rootViewController: viewController)
		navigationVC.navigationBar.prefersLargeTitles = true

		return .init(viewController: navigationVC, animatedType: .fade)
	}
}
