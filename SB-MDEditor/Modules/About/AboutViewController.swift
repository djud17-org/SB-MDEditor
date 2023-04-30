import UIKit

final class AboutViewController: UIViewController {

	private lazy var welcomeLabel = makeWelcomeLabel()
	private lazy var errorView = ErrorView()

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
}

// MARK: - UI
private extension AboutViewController {
	func setup() {}
	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .background)
	}
	func setupConstraints() {
		[
			welcomeLabel,
			errorView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(item)
		}

		welcomeLabel.makeEqualToSuperviewCenter()
		errorView.makeEqualToSuperview()
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
	}
}
