import UIKit

protocol IOpenDocViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: OpenDocModel.ViewModel)
}

final class OpenDocViewController: UIViewController {
	private let interactor: IOpenDocInteractor
	private let router: IOpenDocRouter

	private lazy var emptyView = makeEmptyView()
	private lazy var tableView = makeTableView()

	private var viewModel: OpenDocModel.ViewData {
		didSet {
			updateView()
		}
	}

	init(
		interactor: IOpenDocInteractor,
		router: IOpenDocRouter
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

		setup()
		setupConstraints()
		interactor.viewIsReady()
	}
}
// MARK: - IOpenDocViewController

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModel.ViewModel) {
		switch viewModel {
		case let .openFile(file):
			router.navigate(.toCreateDoc(file))
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

// MARK: - UITableViewDataSource

extension OpenDocViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model: CellViewAnyModel
		let file = viewModel.files[indexPath.row]

		model = OpenDocCellModel(
			name: file.name,
			fieldFileAttributes: file.fileAttributes,
			fieldImage: file.fileImage
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

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}
}

// MARK: - Actions
private extension OpenDocViewController {
	@objc func returnToPreviousPath() {
		interactor.backToPreviousPath()
	}
	@objc func returnToMainScreen() {
		router.navigate(.toSimpleMainModule)
	}

	@objc func transitionOnSelectedName() {
		print("Переход на SelectName модуль")
	}
}

// MARK: - UI
private extension OpenDocViewController {
	func setup() {
		navigationItem.rightBarButtonItems = [
			UIBarButtonItem(
				barButtonSystemItem: .close,
				target: self,
				action: #selector(returnToMainScreen)
			),
			UIBarButtonItem(
				image: Asset.Menu.newFileMenuIcon.image,
				style: .plain,
				target: self,
				action: #selector(transitionOnSelectedName)
			),
			UIBarButtonItem(
				image: Asset.Menu.openMenuIcon.image,
				style: .plain,
				target: self,
				action: #selector(transitionOnSelectedName)
			)
		]
	}

	func makeTableView() -> UITableView {
		let table = UITableView()
		table.register(models: [OpenDocCellModel.self])

		table.dataSource = self
		table.delegate = self

		table.backgroundView = emptyView
		table.separatorStyle = .singleLine
		table.estimatedRowHeight = 64

		return table
	}

	func makeEmptyView() -> UIView {
		let view = EmptyView()
		view.update(with: EmptyInputData.emptyFolder)

		return view
	}

	func updateView() {
		title = viewModel.title
		if viewModel.hasPreviousPath {
			navigationItem.leftBarButtonItem = UIBarButtonItem(
				image: Asset.icBack.image,
				style: .plain,
				target: self,
				action: #selector(returnToPreviousPath)
			)
		}

		if viewModel.files.isEmpty {
			emptyView.show()
		} else {
			emptyView.hide()
		}
	}

	func setupConstraints() {
		view.addSubview(tableView)
		tableView.makeEqualToSuperview()
		emptyView.makeEqualToSuperviewCenter()
	}
}
