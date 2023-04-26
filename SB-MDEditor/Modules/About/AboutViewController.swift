import UIKit

protocol AboutDisplayLogic: AnyObject {
	func render(text: String)
}

final class AboutViewController: UIViewController, AboutDisplayLogic {

	// MARK: - Parameters
	private lazy var welcomeLabel = makeWelcomeLabel()
	private lazy var errorView = ErrorView()
	private lazy var aboutTextView = UITextView()

	// MARK: - Init
	init() {
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
	}

	// MARK: - DO something
	func render(text: String) {
		aboutTextView.text = text
	}
}

// MARK: - UI
private extension AboutViewController {
	func setup() {
		let testMessage = Appearance.errorMessage
		errorView.update(with: testMessage)
		errorView.show()
	}
	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .background)
	}
	func setupConstraints() {
		[
			welcomeLabel,
			errorView,
			aboutTextView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(item)
		}

		welcomeLabel.makeEqualToSuperviewCenter()
		errorView.makeEqualToSuperview()
		aboutTextView.makeEqualToSuperviewToSafeArea()
	}
}

// MARK: - UI make
private extension AboutViewController {
	func makeWelcomeLabel() -> UILabel {
		let label = UILabel()
		label.text = Appearance.welcomeText
		label.textColor = Theme.color(usage: .main)
		label.font = Theme.font(style: .preferred(style: .title1))
		return label
	}
}

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let welcomeText = "Welcome to About"
		static let title = "About"
		static let errorMessage = ErrorInputData(
			emoji: "🙈",
			message: "Переход к экрану: Открыть документ"
		) {
			if
				let rootVC = UIApplication.shared.windows.first?.rootViewController as? IRootViewController,
				let newModule = rootVC.factory?.makeOpenDocModule() {
				rootVC.navigate(to: newModule)
			}
		}
	}
}
