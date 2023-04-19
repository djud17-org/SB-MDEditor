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
	func makeOpenDocModule() -> Module
	func makeCreateDocModule() -> Module
}

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
		let viewController = MainViewController(interactor: interactor, router: router)

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
