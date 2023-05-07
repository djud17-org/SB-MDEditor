import UIKit

protocol IAboutViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: AboutModel.ViewData)
}

final class AboutViewController: UIViewController {
	// MARK: - Parameters

	private let interactor: IAboutInteractor
	var didSendEventClosure: ((AboutViewController.Event) -> Void)?

	private lazy var aboutTextView: UITextView = makeAboutTextView()

	// MARK: - Inits

	init(interactor: IAboutInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		print("AboutViewController deinit")
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

// MARK: - Event
extension AboutViewController {
	enum Event {
		case finish
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewData) {
		aboutTextView.text = viewModel.fileContents
	}
}

// MARK: - Action
private extension AboutViewController {
	@objc func returnToMainScreen() {
		didSendEventClosure?(.finish)
	}
}

// MARK: - UI
private extension AboutViewController {
	func setup() {
		navigationController?.navigationBar.prefersLargeTitles = true
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
			aboutTextView
		].forEach { view.addSubview($0) }

		let insets: UIEdgeInsets = .init(
			top: .zero,
			left: Theme.spacing(usage: .standard),
			bottom: .zero,
			right: Theme.spacing(usage: .standard)
		)
		aboutTextView.makeEqualToSuperviewToSafeArea(insets: insets)
	}
}

// MARK: - UI make
private extension AboutViewController {
	func makeAboutTextView() -> UITextView {
		let textView = UITextView()
		textView.backgroundColor = Theme.color(usage: .background)
		textView.font = Theme.font(style: .caption)
		textView.textColor = Theme.color(usage: .main)
		textView.isEditable = false
		return textView
	}
}

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let title = "About"
	}
}
