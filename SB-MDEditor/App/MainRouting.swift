import UIKit

protocol MainRouting: AnyObject {
	var view: IRootViewController? { get set }

	/// Подготовить модуль к переходу.
	func navigate(_ route: ModuleRoute)
	/// Подготовить модуль к добавлению в стек навигации.
	func push(_ route: ModuleRoute)
	/// Подготовить модуль к представлению.
	func present(_ route: ModuleRoute)
}

extension MainRouting {
	func navigate(_ route: ModuleRoute) {
		guard
			let view = view,
			let factory = view.factory
		else { return }

		let module = route.getModule(factory: factory)
		view.navigate(to: module)
	}

	func push(_ route: ModuleRoute) {
		guard
			let view = view,
			let factory = view.factory
		else { return }

		let module = route.getModule(factory: factory)
		view.push(to: module)
	}

	func present(_ route: ModuleRoute) {
		guard
			let view = view,
			let factory = view.factory
		else { return }

		let module = route.getModule(factory: factory)
		view.present(to: module)
	}
}

enum ModuleRoute {
	case toStart
	case toAbout
	case toMainModule
	case toSimpleMainModule
	case toOpenDoc(File)
	case toCreateDoc

	func getModule(factory: ModuleFactory) -> Module {
		switch self {
		case .toStart:
			return factory.makeStartModule()
		case .toAbout:
			return factory.makeAboutModule()
		case .toMainModule:
			return factory.makeMainModule()
		case let .toOpenDoc(file):
			return factory.makeOpenDocModule(file: file)
		case .toCreateDoc:
			return factory.makeCreateDocModule()
		case .toSimpleMainModule:
			return factory.makeMainSimpleModule()
		}
	}
}
