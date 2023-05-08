import UIKit

final class EmptyView: UIView {
	// MARK: - UI Elements
	private lazy var emptyImageView = makeEmptyImageView()
	private lazy var emptyMessageLabel = makeEmptyMessageLabel()

	// MARK: - Inits
	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setup()
	}
}

// MARK: - Extensions
extension EmptyView {

	/// Метод для обновления данных во View
	@discardableResult
	func update(with data: EmptyInputData) -> Self {
		emptyImageView.image = data.image
		emptyMessageLabel.text = data.message
		return self
	}
}

private extension EmptyView {
	func setup() {
		backgroundColor = .clear
		setupContainer()
	}

	func makeEmptyImageView() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .center
		return image
	}

	func makeEmptyMessageLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.color(usage: .gray)
		label.font = Theme.font(style: .title)
		return label
	}

	func setupContainer() {
		let backgroundView = UIView()
		addSubview(backgroundView)

		backgroundView.makeEqualToSuperview()

		let stackContainer = UIStackView()
		stackContainer.axis = .vertical
		stackContainer.distribution = .fill
		stackContainer.alignment = .center
		stackContainer.spacing = Theme.spacing(usage: .standard2)

		let insets = UIEdgeInsets(
			top: Theme.spacing(usage: .standard),
			left: Theme.spacing(usage: .standard),
			bottom: Theme.spacing(usage: .standard),
			right: Theme.spacing(usage: .standard)
		)

		[
			emptyImageView,
			emptyMessageLabel
		].forEach { stackContainer.addArrangedSubview($0) }

		backgroundView.addSubview(stackContainer)
		stackContainer.makeEqualToSuperview(insets: insets)
	}
}
