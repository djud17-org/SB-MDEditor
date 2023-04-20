//
//  RecentFileCell.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 20.04.2023.
//

import UIKit

final class RecentFileCell: UICollectionViewCell {
	static let identifier = "RecentFileCell"

	// MARK: - UI Elements

	private lazy var fileCoverView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	private lazy var fileNameLabel: UILabel = {
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
		contentView.addSubview(fileCoverView)
		contentView.addSubview(fileNameLabel)
	}

	private func setupLayout() {
		NSLayoutConstraint.activate([
			fileCoverView.topAnchor.constraint(equalTo: topAnchor),
			fileCoverView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			fileCoverView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
			fileCoverView.heightAnchor.constraint(equalToConstant: 150),

			fileNameLabel.topAnchor.constraint(equalTo: fileCoverView.bottomAnchor, constant: 5),
			fileNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			fileNameLabel.heightAnchor.constraint(equalToConstant: 30)
		])
	}

	// MARK: - Data model for cell

	struct RecentFileCellModel {
		let fileCoverColor: UIColor
		let fileName: String
	}
}

// MARK: - CellViewModel extension

extension RecentFileCell.RecentFileCellModel: CellViewModel {
	func setup(cell: RecentFileCell) {
		cell.fileCoverView.backgroundColor = fileCoverColor
		cell.fileNameLabel.text = fileName
	}
}
