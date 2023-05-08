import UIKit

protocol IOpenDocViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: OpenDocModel.ViewModel)
}

final class OpenDocViewController: UIViewController {
	private let interactor: IOpenDocInteractor
	var didSendFileEventClosure: ((OpenDocModel.ViewModel) -> Void)?
	var didSendEventClosure: ((Event) -> Void)?

	private lazy var emptyView = makeEmptyView()
	private lazy var tableView = makeTableView()

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
		applyStyle()
		setupConstraints()

		interactor.viewIsReady()
	}
}

// MARK: - IOpenDocViewController

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModel.ViewModel) {
		switch viewModel {
		case .openFile, .openDir, .createFile, .createDir:
			didSendFileEventClosure?(viewModel)
		case let .showDir(viewData):
			self.viewModel = viewData
			tableView.reloadData()
		}
	}
}

// MARK: - UITableViewDataSource

extension OpenDocViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let file = viewModel.files[indexPath.row]
		let model = OpenDocCell.OpenDocCellModel(
			fileImage: file.fileImage,
			fileName: file.name,
			fileAttr: file.fileAttributes
		)

		return tableView.dequeueReusableCell(withModel: model, for: indexPath)
	}
}

// MARK: - UITableViewDelegate

extension OpenDocViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		interactor.didFileSelected(at: indexPath)
	}
}

// MARK: - Event
extension OpenDocViewController {
	enum Event {
		case finish
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
	@objc func didTapCreateFile() {
		interactor.didTapCreateFile()
	}
	@objc func didTapCreateDir() {
		interactor.didTapCreateDir()
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

	func applyStyle() {
		view.backgroundColor = Theme.color(usage: .white)
	}

	func setupConstraints() {
		view.addSubview(tableView)
		tableView.makeEqualToSuperviewToSafeArea()
	}

	func updateView() {
		title = viewModel.title
		if viewModel.hasPreviousPath {
			navigationItem.leftBarButtonItem = UIBarButtonItem(
				image: Theme.image(kind: .backIcon),
				style: .plain,
				target: self,
				action: #selector(returnToPreviousPath)
			)

			navigationItem.rightBarButtonItems = [
				UIBarButtonItem(
					barButtonSystemItem: .close,
					target: self,
					action: #selector(returnToMainScreen)
				),
				UIBarButtonItem(
					image: Theme.image(kind: .addDirectoryIcon),
					style: .plain,
					target: self,
					action: #selector(didTapCreateDir)
				),
				UIBarButtonItem(
					image: Theme.image(kind: .addFileIcon),
					style: .plain,
					target: self,
					action: #selector(didTapCreateFile)
				)
			]
		}
		emptyView.isHidden = !viewModel.files.isEmpty
	}
}

// MARK: - UI make
private extension OpenDocViewController {
	func makeTableView() -> UITableView {
		let table = UITableView()
		table.register(models: [OpenDocCell.OpenDocCellModel.self])

		table.dataSource = self
		table.delegate = self

		let view = UIView()
		view.addSubview(emptyView)
		emptyView.makeEqualToSuperviewCenter()

		table.backgroundView = view

		table.separatorStyle = .singleLine
		table.estimatedRowHeight = 64
		table.rowHeight = UITableView.automaticDimension

		return table
	}

	func makeEmptyView() -> UIView {
		let view = EmptyView()
		view.update(with: EmptyInputData.emptyFolder)

		return view
	}
}
