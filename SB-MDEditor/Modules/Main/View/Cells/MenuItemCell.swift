//
//  MenuItemCell.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 21.04.2023.
//

import UIKit

final class MenuItemCell: UICollectionViewCell {
	static let identifier = "MenuItemCell"

	// MARK: - UI Elements

	private lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}()

	private lazy var menuItemNameLabel: UILabel = {
		let label = UILabel()
		label.font = Theme.font(style: .smallTitle)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}()

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setupView()
		setupLayout()
	}

	// MARK: - Private funcs

	private func setupView() {
		contentView.addSubview(iconImageView)
		contentView.addSubview(menuItemNameLabel)
	}

	private func setupLayout() {
		NSLayoutConstraint.activate([
			iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			iconImageView.leftAnchor.constraint(equalTo: leftAnchor),
			iconImageView.heightAnchor.constraint(equalToConstant: 30),
			iconImageView.widthAnchor.constraint(equalToConstant: 20),

			menuItemNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			menuItemNameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
			menuItemNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
			menuItemNameLabel.heightAnchor.constraint(equalToConstant: 30)
		])
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
