final class AboutCoordinator: BaseCoordinator {
	private let factory: ModuleFactory
	let router: IRouter

	var finishFlow: (() -> Void)?

	init(router: IRouter, factory: ModuleFactory) {
		self.router = router
		self.factory = factory
	}

	override func start() {
		showAboutModule()
	}

	deinit {
		print("AboutCoordinator deinit")
	}
}

// MARK: - show Modules
private extension AboutCoordinator {
	func showAboutModule() {
		let module = factory.makeAboutModule()
		let moduleVC = module.viewController as? AboutViewController
		moduleVC?.didSendEventClosure = { event in
			switch event {
			case .finish:
				self.finishFlow?()
			}
		}
		router.setRootModule(module)
	}
}
