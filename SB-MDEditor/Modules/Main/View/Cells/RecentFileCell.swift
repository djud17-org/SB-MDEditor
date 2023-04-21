//
//  RecentFileCell.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 20.04.2023.
//

import UIKit

final class RecentFileCell: UICollectionViewCell {
	// MARK: - UI Elements

	private lazy var fileCoverView = UIView()
	private lazy var fileNameLabel = makeFileNameLabel()

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

	struct RecentFileCellModel {
		let fileCoverColor: UIColor
		let fileName: String
	}
}

// MARK: - CellViewModel

extension RecentFileCell.RecentFileCellModel: CellViewModel {
	func setup(cell: RecentFileCell) {
		cell.fileCoverView.backgroundColor = fileCoverColor
		cell.fileNameLabel.text = fileName
	}
}

// MARK: - UI
private extension RecentFileCell {

	func makeFileNameLabel() -> UILabel {
		let label = UILabel()
		label.font = Theme.font(style: .caption)
		label.numberOfLines = .zero

		return label
	}

	func setupLayout() {
		[
			fileCoverView,
			fileNameLabel
		].forEach { contentView.addSubview($0) }

		fileCoverView.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: contentView.topAnchor),
				make.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.spacing(usage: .standard)),
				make.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.spacing(usage: .standard)),
				make.heightAnchor.constraint(equalToConstant: Appearance.fileCoverHeight)
			]
		}

		fileNameLabel.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: fileCoverView.bottomAnchor, constant: Theme.spacing(usage: .standardHalf)),
				make.centerXAnchor.constraint(equalTo: centerXAnchor),
				make.heightAnchor.constraint(equalToConstant: Appearance.fileNameHeight)
			]
		}
	}
}

// MARK: - Appearance
private extension RecentFileCell {
	enum Appearance {
		static let fileCoverHeight = 136.0
		static let fileNameHeight = 24.0
	}
}
