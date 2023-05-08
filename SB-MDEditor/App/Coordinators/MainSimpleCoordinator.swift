final class MainSimpleCoordinator: BaseCoordinator {
	private let factory: ModuleFactory
	private let coordinatorFactory: ICoordinatorFactory
	private let router: IRouter

	var finishFlow: (() -> Void)?

	init(router: IRouter, factory: ModuleFactory, coordinatorFactory: ICoordinatorFactory) {
		self.router = router
		self.factory = factory
		self.coordinatorFactory = coordinatorFactory
	}

	override func start() {
		showMainSimpleModule()
	}

	deinit {
		print("OnboardingCoordinator deinit")
	}
}

// MARK: - run Flows
private extension MainSimpleCoordinator {
	func runAboutFlow() {
		let coordinator = coordinatorFactory.makeAboutCoordinator(router: router)
		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.router.dismissModule()
			self?.removeDependency(coordinator)
			self?.showMainSimpleModule()
		}
		addDependency(coordinator)
		coordinator.start()
	}

	func runOpenDocFlow(file: File) {
		let coordinator = coordinatorFactory.makeOpenDocCoordinator(router: router, file: file)
		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.router.dismissModule()
			self?.removeDependency(coordinator)
			self?.showMainSimpleModule()
		}
		addDependency(coordinator)
		coordinator.start()
	}
}

// MARK: - show Modules
private extension MainSimpleCoordinator {
	func showMainSimpleModule() {
		let module = factory.makeMainSimpleModule()
		let moduleVC = module.viewController as? MainSimpleViewController
		moduleVC?.didSendEventClosure = { event in
			let action: (() -> Void)
			switch event {
			case .openDoc:
				action = {
					let file = File.makePrototypeDir()
					self.runOpenDocFlow(file: file)
				}
			case .createDoc:
				action = {
					let file = File.makePrototypeFile()
					self.runOpenDocFlow(file: file)
				}
			case .about:
				action = {
					self.runAboutFlow() // вариант с флоу
					// self.showAboutModule() // вариант без flow
				}
			}
			return action
		}
		router.setRootModule(module)
	}

	func showAboutModule() {
		let module = factory.makeAboutModule()
		let moduleVC = module.viewController as? AboutViewController
		moduleVC?.didSendEventClosure = { event in
			switch event {
			case .finish:
				self.showMainSimpleModule()
			}
		}
		router.setRootModule(module)
	}
}
