import UIKit

protocol ICreateDocViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: CreateDocModel.ViewModel)
}

final class CreateDocViewController: UIViewController {
	private let interactor: ICreateDocInteractor
	var didSendFileEventClosure: ((CreateDocModel.ViewModel) -> Void)?

	private lazy var createTextView: UITextView = makeCreateTextView()

	private var viewModel: CreateDocModel.ViewData {
		didSet {
			updateView()
		}
	}

	// MARK: - Inits

	init(interactor: ICreateDocInteractor) {
		self.interactor = interactor
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

	deinit {
		print("CreateDocViewController deinit")
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
		case .backDir:
			didSendFileEventClosure?(viewModel)
		case let .saveFile(file):
			print("Нужно сохранить файл", file.name)
		}
	}
}

// MARK: - Actions
private extension CreateDocViewController {
	@objc func returnToPreviousPath() {
		interactor.backToPreviousPath()
	}
	@objc func returnToBackScreen() {
		interactor.backToPreviousPath()
	}
}

// MARK: - UI
private extension CreateDocViewController {
	func setup() {
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(returnToBackScreen)
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
