import UIKit

protocol IRootViewController: AnyObject {
	typealias Factory = ModuleFactory
	var factory: Factory? { get set }

	func navigate(to module: Module)
	func push(to module: Module)
	func present(to module: Module)
	func start()
}

class RootViewController: UIViewController, IRootViewController {
	var factory: Factory?
	private var current = UIViewController()

	// MARK: - Init
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - IRootViewController

extension RootViewController {
	func navigate(to module: Module) {
		switch module.animatedType {
		case .none:
			animateNoneTransition(
				to: module.viewController,
				completion: module.completion
			)
		case .dismiss:
			animateDismissTransition(
				to: module.viewController,
				completion: module.completion
			)
		case .fade:
			animateFadeTransition(
				to: module.viewController,
				completion: module.completion
			)
		}
	}

	func push(to module: Module) {
		switch current {
		case let navigationVC as UINavigationController:
			navigationVC.pushViewController(module.viewController, animated: true)
		case let tabBarVC as UITabBarController:
			if let navigationVC = tabBarVC.selectedViewController as? UINavigationController {
				navigationVC.pushViewController(module.viewController, animated: true)
			} else {
				fallthrough
			}
		default:
			navigate(to: module)
		}
	}

	func present(to module: Module) {
		switch current {
		case let navigationVC as UINavigationController:
			navigationVC.present(module.viewController, animated: true, completion: module.completion)
		case let tabBarVC as UITabBarController:
			if let navigationVC = tabBarVC.selectedViewController as? UINavigationController {
				navigationVC.present(module.viewController, animated: true, completion: module.completion)
			} else {
				fallthrough
			}
		default:
			navigate(to: module)
		}
	}

	func start() {
		guard let factory = factory else { return }
		current = factory.makeStartModule().viewController
		addChild(current)
		current.view.frame = view.bounds
		view.addSubview(current.view)
		current.didMove(toParent: self)
	}
}

// MARK: - Transition

private extension RootViewController {
	func animateNoneTransition(
		to new: UIViewController,
		completion: (() -> Void)? = nil
	) {
		addChild(new)
		new.view.frame = view.bounds
		view.addSubview(new.view)
		new.didMove(toParent: self)
		current.willMove(toParent: nil)
		current.view.removeFromSuperview()
		current.removeFromParent()
		current = new
	}

	// swiftlint:disable multiple_closures_with_trailing_closure
	func animateFadeTransition(
		to new: UIViewController,
		completion: (() -> Void)? = nil
	) {
		current.willMove(toParent: nil)
		addChild(new)

		transition(
			from: current,
			to: new,
			duration: 0.3,
			options: [.transitionCrossDissolve, .curveEaseOut],
			animations: { }
		) { _ in
			self.current.removeFromParent()
			new.didMove(toParent: self)
			self.current = new
			completion?()
		}
	}

	func animateDismissTransition(
		to new: UIViewController,
		completion: (() -> Void)? = nil
	) {
		let initialFrame = CGRect(
			x: -view.bounds.width,
			y: 0,
			width: view.bounds.width,
			height: view.bounds.height
		)
		current.willMove(toParent: nil)
		addChild(new)
		new.view.frame = initialFrame

		transition(
			from: current,
			to: new,
			duration: 0.3,
			options: [],
			animations: { new.view.frame = self.view.bounds }
		) { _ in
			self.current.removeFromParent()
			new.didMove(toParent: self)
			self.current = new
			completion?()
		}
	}
}
