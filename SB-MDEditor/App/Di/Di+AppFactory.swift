import UIKit

// MARK: - AppFactory

protocol IAppFactory {
	func makeKeyWindowWithCoordinator(scene: UIWindowScene) -> (UIWindow, ICoordinator)
}

extension Di: IAppFactory {
	func makeKeyWindowWithCoordinator(scene: UIWindowScene) -> (UIWindow, ICoordinator) {
		let window = UIWindow(windowScene: scene)

		let navigationController = UINavigationController()
		navigationController.navigationBar.prefersLargeTitles = true

		let router = Router(rootController: navigationController)
		let cooridnator = makeApplicationCoordinator(router: router)

		window.rootViewController = navigationController
		return (window, cooridnator)
	}
}
