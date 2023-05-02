import UIKit

protocol ICreateDocViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: CreateDocModel.ViewModel)
}

final class CreateDocViewController: UIViewController {
	// MARK: - Parameters

	private let interactor: ICreateDocInteractor
	private let router: ICreateDocRouter

	private lazy var createTextView: UITextView = makeCreateTextView()

	private var viewModel: CreateDocModel.ViewData {
		didSet {
			updateView()
		}
	}

	// MARK: - Inits

	init(
		interactor: ICreateDocInteractor,
		router: ICreateDocRouter
	) {
		self.interactor = interactor
		self.router = router
		viewModel = .init(
			title: "Untitle",
			fileContents: "",
			hasPreviousPath: false
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
		applyStyle()
		setupConstraints()

		interactor.viewIsReady()
	}
}

// MARK: - IOpenDocViewController

extension CreateDocViewController: ICreateDocViewController {
	func render(viewModel: CreateDocModel.ViewModel) {
		switch viewModel {
		case let .showFile(viewData):
			self.viewModel = viewData
		case let .backDir(file):
			router.navigate(.toOpenDoc(file))
		case let .saveFile(file):
			print("Нужно сохранить файл")
		}
	}
}

// MARK: - Actions
private extension CreateDocViewController {
	@objc func returnToPreviousPath() {
		interactor.backToPreviousPath()
	}
	@objc func returnToMainScreen() {
		router.navigate(.toSimpleMainModule)
	}
}

// MARK: - UI
private extension CreateDocViewController {
	func setup() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(returnToMainScreen)
		)
	}

	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .white)
	}

	func setupConstraints() {
		[
			createTextView
		].forEach { view.addSubview($0) }

		let insets: UIEdgeInsets = .init(
			top: .zero,
			left: Theme.spacing(usage: .standard),
			bottom: .zero,
			right: Theme.spacing(usage: .standard)
		)
		createTextView.makeEqualToSuperviewToSafeArea(insets: insets)
	}

	func updateView() {
		title = viewModel.title
		createTextView.text = viewModel.fileContents
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

// MARK: - UI make
private extension CreateDocViewController {
	func makeCreateTextView() -> UITextView {
		let textView = UITextView()
		textView.backgroundColor = Theme.color(usage: .background)
		textView.font = Theme.font(style: .caption)
		textView.textColor = Theme.color(usage: .main)
		textView.isEditable = false
		return textView
	}
}

// MARK: - Appearance
private extension CreateDocViewController {
	enum Appearance {
		static let title = "Create Doc"
	}
}
