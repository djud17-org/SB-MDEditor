import UIKit

/// Класс ячейки файлa/папки
final class OpenDocCell: UITableViewCell {

	// MARK: - UI Elements
	private lazy var fileImageView = makeFileImageView()
	private lazy var fileNameLabel = makeFileNameLabel()
	private lazy var fileAttrLabel = makeFileAttrLabel()

	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		applyStyle()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func prepareForReuse() {
		super.prepareForReuse()
		fileImageView.image = nil
		fileNameLabel.text = nil
		fileAttrLabel.text = nil
	}

	// MARK: - Model for cell
	struct OpenDocCellModel {
		let fileImage: UIImage
		let fileName: String
		let fileAttr: String
	}
}

// MARK: - CellViewModel

extension OpenDocCell.OpenDocCellModel: CellViewModel {
	func setup(cell: OpenDocCell) {
		cell.fileImageView.image = fileImage
		cell.fileNameLabel.text = fileName
		cell.fileAttrLabel.text = fileAttr
	}
}

// MARK: - UI
private extension OpenDocCell {
	func applyStyle() {
		contentView.backgroundColor = Theme.color(usage: .background)
	}

	func setupConstraints() {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.spacing = Theme.spacing(usage: .standardHalf)
		[
			fileNameLabel,
			fileAttrLabel
		].forEach { vStack.addArrangedSubview($0) }

		let hStack = UIStackView()
		hStack.spacing = Theme.spacing(usage: .standard)
		[
			fileImageView,
			vStack
		].forEach { hStack.addArrangedSubview($0) }
		fileImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		contentView.addSubview(hStack)

		let insets: UIEdgeInsets = .init(
			top: Theme.spacing(usage: .standard),
			left: Theme.spacing(usage: .standard),
			bottom: Theme.spacing(usage: .standard),
			right: Theme.spacing(usage: .standard)
		)

		hStack.makeEqualToSuperview(insets: insets)
	}
}

// MARK: - UI make
private extension OpenDocCell {
	func makeFileImageView() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .center

		return image
	}

	func makeFileNameLabel() -> UILabel {
		let label = UILabel()
		label.font = Theme.font(style: .preferred(style: .callout))
		label.numberOfLines = .zero

		return label
	}

	func makeFileAttrLabel() -> UILabel {
		let label = UILabel()
		label.font = Theme.font(style: .caption)
		label.numberOfLines = .zero
		label.textAlignment = .right

		return label
	}
}
