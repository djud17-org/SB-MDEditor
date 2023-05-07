final class OnboardingCoordinator: BaseCoordinator {
	private let factory: ModuleFactory
	let router: IRouter

	var finishFlow: (() -> Void)?

	init(router: IRouter, factory: ModuleFactory) {
		self.router = router
		self.factory = factory
	}

	override func start() {
		showOnboardingModule()
	}

	deinit {
		print("OnboardingCoordinator deinit")
	}

	func showOnboardingModule() {
		let module = factory.makeOnboardingModule()
		let moduleVC = module.viewController as? OnboardingViewController
		moduleVC?.didSendEventClosure = { event in
			switch event {
			case .start:
				self.finishFlow?()
			}
		}
		router.setRootModule(module)
	}
}
