//
//  OpenDocCell.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

/// Класс ячейки файлa/папки
class OpenDocCell: UITableViewCell {
	static let identifier = "OpenDocCell"

	// MARK: - UI Elements
	lazy var fieldImage = UIImageView()
	lazy var fieldFileName = UILabel()

	lazy var fieldFileAttributes: UILabel = {
		let label = UILabel()
		label.font = Theme.font(style: .footnote)

		return label
	}()

	// MARK: - Lifecycle
	override func layoutSubviews() {
		super.layoutSubviews()

		setupLayout()
	}

	// MARK: - SetupLayout
	private func setupLayout() {
		[
			fieldImage,
			fieldFileName,
			fieldFileAttributes
		].forEach { contentView.addSubview($0) }

		fieldImage.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.spacing(usage: .standard)),
				make.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.spacing(usage: .standard))
			]
		}
			fieldFileName.makeConstraints { make in
				[
					make.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.spacing(usage: .standard)),
					make.leadingAnchor.constraint(equalTo: fieldImage.trailingAnchor, constant: Theme.spacing(usage: .standard))
				]
			}

		fieldFileAttributes.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.spacing(usage: .standard2)),
				make.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.spacing(usage: .standard))
			]
		}
	}
}
