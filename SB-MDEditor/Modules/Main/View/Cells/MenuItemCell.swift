//
//  MenuItemCell.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 21.04.2023.
//

import UIKit

final class MenuItemCell: UICollectionViewCell {
	// MARK: - UI Elements

	private lazy var iconImageView = makeIconImageView()
	private lazy var menuItemNameLabel = makeMenuItemNameLabel()

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupLayout()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setupLayout()
	}

	// MARK: - Data model for cell

	struct MenuItemCellModel {
		let itemIcon: UIImage?
		let itemName: String
	}
}

// MARK: - CellViewModel extension

extension MenuItemCell.MenuItemCellModel: CellViewModel {
	func setup(cell: MenuItemCell) {
		cell.iconImageView.image = itemIcon
		cell.menuItemNameLabel.text = itemName
	}
}

// MARK: - UI
private extension MenuItemCell {
	func makeMenuItemNameLabel() -> UILabel {
		let label = UILabel()
		label.font = Theme.font(style: .smallTitle)
		label.numberOfLines = 0

		return label
	}

	func makeIconImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}

	func setupLayout() {
		[
			iconImageView,
			menuItemNameLabel
		].forEach { contentView.addSubview($0) }

		iconImageView.makeConstraints { make in
			[
				make.centerYAnchor.constraint(equalTo: centerYAnchor),
				make.leftAnchor.constraint(equalTo: leftAnchor),
				make.heightAnchor.constraint(equalToConstant: Appearance.iconImageHeight),
				make.widthAnchor.constraint(equalToConstant: Appearance.iconImageWidth)
			]
		}

		menuItemNameLabel.makeConstraints { make in
			[
				make.centerYAnchor.constraint(equalTo: centerYAnchor),
				make.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: Theme.spacing(usage: .standard)),
				make.rightAnchor.constraint(equalTo: rightAnchor),
				make.heightAnchor.constraint(equalToConstant: Appearance.labelNameHeight)
			]
		}
	}
}

// MARK: - Appearance
private extension MenuItemCell {
	enum Appearance {
		static let iconImageHeight = 30.0
		static let iconImageWidth = 20.0
		static let labelNameHeight = 30.0
	}
}
