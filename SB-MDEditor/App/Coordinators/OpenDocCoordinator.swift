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
			case let .createFile(file):
				let initialFile = File.makePrototypeFile()
				initialFile.path = file.fullname
				self.showCreateDocModule(file: initialFile)
			case .showDir:
				break
			case let .openDir(file):
				self.showOpenDocModule(file: file)
			case let .createDir(file):
				let initialFile = File.makePrototypeDir()
				initialFile.path = file.fullname
				print("Создать каталог в текущей директории")
				// self.showCreateDocModule(file: initialFile)
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
