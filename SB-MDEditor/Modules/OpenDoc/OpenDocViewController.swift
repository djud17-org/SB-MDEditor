import UIKit

protocol IOpenDocViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: OpenDocModel.ViewModel)
}

final class OpenDocViewController: UITableViewController {
	private let interactor: IOpenDocInteractor
	var didSendFileEventClosure: ((OpenDocModel.ViewModel) -> Void)?
	var didSendEventClosure: ((Event) -> Void)?

	private var viewModel: OpenDocModel.ViewData {
		didSet {
			updateView()
		}
	}

	// MARK: - Inits

	init(interactor: IOpenDocInteractor) {
		self.interactor = interactor
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

	deinit {
		print("OpenDocViewController deinit")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		setupTableView()

		interactor.viewIsReady()
	}
}

// MARK: - IOpenDocViewController

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModel.ViewModel) {
		switch viewModel {
		case .openFile, .openDir:
			didSendFileEventClosure?(viewModel)
		case let .showDir(viewData):
			self.viewModel = viewData
			tableView.reloadData()
		}
	}
}

// MARK: - Event
extension OpenDocViewController {
	enum Event {
		case finish
	}
}

// MARK: - UITableViewController

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
	@objc func returnToMainScreen() {
		didSendEventClosure?(.finish)
	}
}

// MARK: - UI
private extension OpenDocViewController {
	func setup() {
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(returnToMainScreen)
		)
	}

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
