//
//  OpenDocCell.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 23.04.2023.
//

import UIKit

/// Класс ячейки файлa/папки
final class OpenDocCell: UITableViewCell {

	// MARK: - UI Elements
	lazy var fieldImage = makeFieldImage()
	lazy var fieldFileName = makeFieldFileName()
	lazy var fieldFileAttributes = makeFieldFileAttributes()

	// MARK: - Lifecycle
	override func layoutSubviews() {
		super.layoutSubviews()
		applyStyle()
		setupLayout()
	}

	private func makeFieldImage() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit

		return image
	}

	private func makeFieldFileName() -> UILabel {
		let label = UILabel()
		label.numberOfLines = .zero

		return label
	}

	private func makeFieldFileAttributes() -> UILabel {
		let label = UILabel()
		label.font = Theme.font(style: .footnote)
		label.numberOfLines = .zero

		return label
	}

	private func applyStyle() {
		contentView.backgroundColor = Theme.color(usage: .background)
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
				make.leadingAnchor.constraint(equalTo: fieldImage.trailingAnchor, constant: Theme.spacing(usage: .standard)),
				make.heightAnchor.constraint(equalToConstant: Theme.spacing(usage: .standard2))
			]
		}

		fieldFileAttributes.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: fieldFileName.bottomAnchor, constant: Theme.spacing(usage: .standard)),
				make.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.spacing(usage: .standard)),
				make.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.spacing(usage: .standardHalf)),
				make.heightAnchor.constraint(equalToConstant: Theme.spacing(usage: .standard2))
			]
		}
	}
}
