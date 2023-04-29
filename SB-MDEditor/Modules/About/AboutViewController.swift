import UIKit

protocol IDisplayLogic: AnyObject {
	/// Рендрит представление данных на экран контроллера.
	/// - Parameter text: Текстовое представление данных.
	func render(text: AboutModels.ViewData)
}

final class AboutViewController: UIViewController {
	// MARK: - Parameters

	private let interactor: IBusinessLogic
	private let router: (NSObjectProtocol & IRoutingLogic)

	private lazy var aboutTextView: UITextView = makeAboutTextView()

	// MARK: - Inits

	init(
		interactor: IBusinessLogic,
		router: (NSObjectProtocol & IRoutingLogic)
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

		interactor.readFileContents()
	}
}

// MARK: - IDisplayLogic

extension AboutViewController: IDisplayLogic {
	func render(text: AboutModels.ViewData) {
		aboutTextView.text = text.fileContents
	}
}

// MARK: - Action
private extension AboutViewController {
	@objc func returnToMainScreen() {
		router.navigate(.toMainModule)
	}
}

// MARK: - UI
private extension AboutViewController {
	func setup() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(returnToMainScreen)
		)
	}

	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .background)
	}

	func setupConstraints() {
		[
			aboutTextView
		].forEach { item in
			view.addSubview(item)
		}

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
		return textView
	}
}

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let title = "About"
	}
}
