import UIKit

final class OnboardingViewController: UIViewController {
	var didSendEventClosure: ((OnboardingViewController.Event) -> Void)?

	private lazy var startButton: UIButton = makeStartButton()

	// MARK: - Inits

	deinit {
		print("OnboardingViewController deinit")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		applyStyle()
		setupConstraints()
	}
}

// MARK: - Event
extension OnboardingViewController {
	enum Event {
		case start
	}
}

// MARK: - Actions
private extension OnboardingViewController {
	@objc func didTapStartButton(_ sender: Any) {
		didSendEventClosure?(.start)
	}
}

// MARK: - UI
private extension OnboardingViewController {
	func setup() {
		startButton.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
	}
	func applyStyle() {
		view.backgroundColor = Theme.color(usage: .white)
	}
	func setupConstraints() {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = Theme.spacing(usage: .standard)

		[
			startButton
		].forEach { item in
			stackView.addArrangedSubview(item)
		}

		view.addSubview(stackView)
		stackView.makeEqualToSuperviewCenter()

		startButton.makeConstraints { make in
			make.size(.init(width: Appearance.buttonSize.width, height: Appearance.buttonSize.height))
		}
	}
}

// MARK: - UI make
private extension OnboardingViewController {
	func makeStartButton() -> UIButton {
		let button = UIButton()
		button.setTitle(Appearance.buttonText, for: .normal)
		button.titleLabel?.font = Theme.font(style: .smallTitle)
		button.backgroundColor = Theme.color(usage: .accent)
		button.setTitleColor(Theme.color(usage: .attention), for: .normal)
		button.layer.cornerRadius = Theme.size(kind: .cornerRadius)

		return button
	}
}

// MARK: - Appearance
private extension OnboardingViewController {
	enum Appearance {
		static let buttonText = "Onboarding"
		static let buttonSize: CGSize = .init(width: 200, height: 50)
	}
}
