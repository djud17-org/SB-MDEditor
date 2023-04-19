import UIKit

final class ErrorView: UIView {
	private var onTryAgain: VoidClosure?

	private lazy var messageLabel = makeMessageLabel()
	private lazy var tryAgainButton = makeTryAgainButton()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setup()
	}
}

// MARK: - Public methods
extension ErrorView {
	@discardableResult
	func update(with data: ErrorInputData) -> Self {
		messageLabel.text = String(data.emoji) + " " + data.message
		onTryAgain = data.onTryAgain
		tryAgainButton.isHidden = data.onTryAgain == nil

		return self
	}
}

// MARK: - Actions
private extension ErrorView {
	@objc private func tryAgainTapped() {
		onTryAgain?()
	}
}

// MARK: - UI
private extension ErrorView {
	func setup() {
		backgroundColor = .clear
		setupContainer()
	}

	func makeMessageLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.color(usage: .attention)
		label.font = Theme.font(style: .preferred(style: .callout))
		label.numberOfLines = 0
		return label
	}
	func makeTryAgainButton() -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle("Try Again", for: .normal)
		button.tintColor = Theme.color(usage: .accent)
		button.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
		return button
	}
	func setupContainer() {
		let backgroundView = UIView()
		backgroundView.backgroundColor = Theme.color(usage: .white)
		addSubview(backgroundView)
		backgroundView.makeConstraints { make in
			[
				make.leadingAnchor.constraint(equalTo: leadingAnchor),
				make.trailingAnchor.constraint(equalTo: trailingAnchor),
				make.bottomAnchor.constraint(equalTo: bottomAnchor)
			]
		}

		let stackContainer = UIStackView()
		stackContainer.axis = .vertical
		stackContainer.distribution = .fill
		stackContainer.alignment = .fill
		stackContainer.spacing = 0

		let insets = UIEdgeInsets(
			top: 0,
			left: 16,
			bottom: 16,
			right: 16
		)

		[
			messageLabel,
			tryAgainButton
		].forEach { stackContainer.addArrangedSubview($0) }

		backgroundView.addSubview(stackContainer)
		stackContainer.makeEqualToSuperview(insets: insets)
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewProvider2: PreviewProvider {
	static var previews: some View {
		let erorrView = ErrorView()
		erorrView.update(with: ErrorInputData.applicationError)
		return Group {
			VStack(spacing: 0) {
				erorrView.preview().frame(height: 100).padding(.bottom, 20)
			}
			.preferredColorScheme(.light)
		}
	}
}
#endif
