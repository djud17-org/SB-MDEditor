import UIKit

// MARK: - AppFactory

protocol AppFactory {
	static func makeKeyWindow(scene: UIWindowScene) -> UIWindow
}

extension Di: AppFactory {
	static func makeKeyWindow(scene: UIWindowScene) -> UIWindow {
		let window = UIWindow(windowScene: scene)

		let rootViewController = RootViewController()
		let di = Di(rootVC: rootViewController)
		rootViewController.factory = di
		rootViewController.start()

		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
		return window
	}
}
