import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	private let appFactory: IAppFactory = Di()
	private var appCoordinator: ICoordinator?
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator(scene: scene)
		self.window = window
		self.appCoordinator = coordinator

		window.makeKeyAndVisible()
		coordinator.start()
	}
}
