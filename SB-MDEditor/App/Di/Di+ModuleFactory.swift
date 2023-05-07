import UIKit

protocol Presentable {
	func toPresent() -> UIViewController?
}

// MARK: - Module

enum AnimatedTransitionType {
	case none
	case fade
	case dismiss
}

struct Module: Presentable {
	let viewController: UIViewController
	var animatedType: AnimatedTransitionType = .none
	var completion: (() -> Void)?

	func toPresent() -> UIViewController? {
		self.viewController
	}
}

// MARK: - ModuleFactory

protocol ModuleFactory: AnyObject {
	func makeStartModule() -> Module
	func makeAboutModule() -> Module
	func makeOpenDocModule(file: File) -> Module
	func makeCreateDocModule(file: File) -> Module
	func makeMainSimpleModule() -> Module
	func makeOnboardingModule() -> Module
}

extension Di {
	func makeAboutModule(dep: AllDependencies) -> Module {
		let presenter = AboutPresenter()
		let interactor = AboutInteractor(presenter: presenter, dep: dep)
		let viewController = AboutViewController(interactor: interactor)

		presenter.viewController = viewController
		return .init(viewController: viewController, animatedType: .fade)
	}

	func makeOpenDocModule(file: File, dep: AllDependencies) -> Module {
		let presenter = OpenDocPresenter()
		let interactor = OpenDocInteractor(presenter: presenter, dep: dep, initialFile: file)

		let viewController = OpenDocViewController(interactor: interactor)

		presenter.viewController = viewController

		return .init(viewController: viewController, animatedType: .dismiss)
	}

	func makeCreateDocModule(file: File, dep: AllDependencies) -> Module {
		let presenter = CreateDocPresenter()
		let interactor = CreateDocInteractor(presenter: presenter, dep: dep, initialFile: file)

		let viewController = CreateDocViewController(interactor: interactor)

		presenter.viewController = viewController

		return .init(viewController: viewController, animatedType: .fade)
	}

	func makeMainSimpleModule(dep: AllDependencies) -> Module {
		let viewController = MainSimpleViewController()
		return .init(viewController: viewController)
	}

	func makeOnboardingModule(dep: AllDependencies) -> Module {
		let viewController = OnboardingViewController()
		return .init(viewController: viewController)
	}
}
