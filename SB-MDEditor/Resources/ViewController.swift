import UIKit

final class ViewController: UIViewController {

	private lazy var welcomeLabel = makeWelcomeLabel()

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
private extension ViewController {
	func setup() {}
	func applyStyle() {
		view.backgroundColor = Appearance.backgroundColor
	}
	func setupConstraints() {
		[
			welcomeLabel
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(item)
		}

		welcomeLabel.makeEqualToSuperviewCenter()
	}
}

// MARK: - UI make
private extension ViewController {
	func makeWelcomeLabel() -> UILabel {
		let label = UILabel()
		label.text = Appearance.welcomeText
		label.font = Theme.font(style: .preferred(style: .largeTitle))
		return label
	}
}

// MARK: - Appearance
private extension ViewController {
	enum Appearance {
		static let welcomeText = "Welcome to SB-MDEditor"
		static let backgroundColor = Theme.color(usage: .background)
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewProvider: PreviewProvider {
	static var previews: some View {
		let viewController = ViewController()
		let labelView = UIImageView(image: Theme.image(kind: .aboutMenuIcon)) as UIView
		let labelView2 = UIImageView(image: Theme.image(kind: .emptyPlaceholder)) as UIView
		Group {
			viewController.preview()
			VStack(spacing: 0) {
				labelView.preview().frame(height: 100).padding(.bottom, 20)
				labelView2.preview().frame(height: 100).padding(.bottom, 20)
			}
			.preferredColorScheme(.light)
		}
	}
}
#endif
