import UIKit

protocol IOpenDocViewController: AnyObject {
	func render(viewModel: OpenDocModel.ViewModel)
}

final class OpenDocViewController: UITableViewController {
	private let interactor: IOpenDocInteractor
	private let router: (NSObjectProtocol & IOpenDocRoutingLogic)

	private var viewModel: OpenDocModel.ViewData {
		didSet {
			updateView()
		}
	}

	init(
		interactor: IOpenDocInteractor,
		router: NSObjectProtocol & IOpenDocRoutingLogic
	) {
		self.interactor = interactor
		self.router = router
		viewModel = .init(
			title: "/",
			hasPreviousPath: false,
			files: []
		)

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupTableView()
		interactor.viewIsReady()
	}
}

// MARK: - IOpenDocViewController

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModel.ViewModel) {
		switch viewModel {
		case let .openFile(file):
			print("надо октрыть файл по пути \(file.fullname)")
		case let .showDir(viewData):
			self.viewModel = viewData
			tableView.reloadData()
		case let .openDir(file):
			router.navigate(.toOpenDoc(file))
		case let .backDir(file):
			router.navigate(.toOpenDoc(file))
		}
	}
}

extension OpenDocViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model: CellViewAnyModel
		let file = viewModel.files[indexPath.row]

		model = OpenDocCellModel(
			name: file.name,
			fieldFileAttributes: file.fileAttributes,
			fieldImage: file.fileImage
		)

		return tableView.dequeueReusableCell(withModel: model, for: indexPath)
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		interactor.didFileSelected(at: indexPath)
	}
}

// MARK: - Actions
private extension OpenDocViewController {
	@objc func returnToPreviousPath() {
		interactor.backToPreviousPath()
	}
}

// MARK: - UI
private extension OpenDocViewController {
	func setupTableView() {
		tableView.separatorStyle = .singleLine
		tableView.register(OpenDocCell.self, forCellReuseIdentifier: OpenDocCell.identifier)
		tableView.rowHeight = 64
	}

	func updateView() {
		title = viewModel.title
		if viewModel.hasPreviousPath {
			navigationItem.leftBarButtonItem = UIBarButtonItem(
				title: "<<",
				style: .plain,
				target: self,
				action: #selector(returnToPreviousPath)
			)
		}
	}
}
