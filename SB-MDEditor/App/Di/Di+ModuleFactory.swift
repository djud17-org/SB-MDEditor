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
