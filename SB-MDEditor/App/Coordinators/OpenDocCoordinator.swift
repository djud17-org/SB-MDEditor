final class OpenDocCoordinator: BaseCoordinator {
	private let factory: ModuleFactory
	private let router: IRouter
	private let initialFile: File

	var finishFlow: (() -> Void)?

	init(
		router: IRouter,
		file: File,
		factory: ModuleFactory
	) {
		self.router = router
		self.initialFile = file
		self.factory = factory
	}

	override func start() {
		switch initialFile.filetype {
		case .directory:
			showOpenDocModule(file: initialFile)
		case .file:
			showCreateDocModule(file: initialFile)
		}
	}

	deinit {
		print("OpenDocCoordinator deinit")
	}
}

// MARK: - show Modules
private extension OpenDocCoordinator {
	func showOpenDocModule(file: File) {
		let module = factory.makeOpenDocModule(file: file)
		let moduleVC = module.toPresent() as? OpenDocViewController
		moduleVC?.didSendFileEventClosure = { event in
			switch event {
			case let .openFile(file):
				self.showCreateDocModule(file: file)
			case .showDir:
				break
			case let .openDir(file):
				self.showOpenDocModule(file: file)
			}
		}
		moduleVC?.didSendEventClosure = { event in
			switch event {
			case .finish:
				self.finishFlow?()
			}
		}
		router.setRootModule(module)
	}

	func showCreateDocModule(file: File) {
		let module = factory.makeCreateDocModule(file: file)
		let moduleVC = module.toPresent() as? CreateDocViewController
		moduleVC?.didSendFileEventClosure = { event in
			switch event {
			case .saveFile, .showFile:
				break
			case let .backDir(file):
				self.showOpenDocModule(file: file)
			}
		}
		router.setRootModule(module)
	}
}
