import UIKit

protocol AboutDisplayLogic: AnyObject {
	func render(text: String)
}

final class AboutViewController: UIViewController, AboutDisplayLogic {
	// MARK: - Parameters

	private let interactor: AboutBusinessLogic?
	private let router: (NSObjectProtocol & AboutRoutingLogic)

	private lazy var aboutTextView = UITextView()

	// MARK: - Inits

	init(
		interactor: AboutBusinessLogic,
		router: (NSObjectProtocol & AboutRoutingLogic)
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
		interactor?.readFileContents()
	}

	// MARK: - DO something
	func render(text: String) {
		aboutTextView.text = text
	}
}

// MARK: - UI
private extension AboutViewController {
	func setup() { }
	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .background)
	}
	func setupConstraints() {
		[
			aboutTextView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
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
		textView.font = Theme.font(style: .title)
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
