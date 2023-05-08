final class AppCoordinator: BaseCoordinator {
	private let factory: ICoordinatorFactory
	private let router: IRouter

	private var isOnboarding = false

	init(router: IRouter, factory: ICoordinatorFactory) {
		self.router = router
		self.factory = factory
	}

	override func start() {
		if isOnboarding {
			runMainFlow()
		} else {
			runOnboardingFlow()
		}
	}

	func runOnboardingFlow() {
		let coordinator = factory.makeOnboardingCoordinator(router: router)
		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.isOnboarding = true
			self?.start()
			self?.removeDependency(coordinator)
		}
		coordinator.start()
		childCoordinators.append(coordinator)
	}

	func runMainFlow() {
		let coordinator = factory.makeMainSimpleCoordinator(router: router)
		coordinator.start()
		childCoordinators.append(coordinator)
	}
}
