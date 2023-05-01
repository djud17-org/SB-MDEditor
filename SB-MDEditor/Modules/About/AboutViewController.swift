import UIKit

protocol IAboutViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: AboutModel.ViewData)
}

final class AboutViewController: UIViewController {
	// MARK: - Parameters

	private let interactor: IAboutInteractor
	private let router: IAboutRouter

	private lazy var aboutTextView: UITextView = makeAboutTextView()

	// MARK: - Inits

	init(
		interactor: IAboutInteractor,
		router: IAboutRouter
	) {
		self.interactor = interactor
		self.router = router
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

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewData) {
		aboutTextView.text = viewModel.fileContents
	}
}

// MARK: - Action
private extension AboutViewController {
	@objc func returnToMainScreen() {
		router.navigate(.toSimpleMainModule)
	}
}

// MARK: - UI
private extension AboutViewController {
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
			aboutTextView
		].forEach { view.addSubview($0) }

		aboutTextView.makeEqualToSuperviewToSafeArea()
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
