//
//  EmptyView.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 20.04.2023.
//

import UIKit

final class EmptyView: UIView {
	private lazy var emptyPictureLabel = makeEmptyPictureLabel()
	private lazy var emptyTextLabel = makeEmptyTextLabel()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setup()
	}
}

private extension EmptyView {
	func setup() {
		backgroundColor = .clear
		setupContainer()
	}

	func makeEmptyPictureLabel() -> UILabel {
		let label = UILabel()
		label.text = "📂"
		label.font = Theme.font(style: .largeTitle)
		return label
	}

	func makeEmptyTextLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.color(usage: .gray)
		label.text = "Empty folder"
		label.font = Theme.font(style: .title)
		return label
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
		stackContainer.alignment = .center
		stackContainer.spacing = 16

		let insets = UIEdgeInsets(
			top: 0,
			left: 16,
			bottom: 16,
			right: 16
		)

		[
			emptyPictureLabel,
			emptyTextLabel
		].forEach { stackContainer.addArrangedSubview($0) }

		backgroundView.addSubview(stackContainer)
		stackContainer.makeEqualToSuperview(insets: insets)
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct EmptyViewProvider: PreviewProvider {
	static var previews: some View {
		let emptyView = EmptyView()
		return Group {
			VStack(spacing: 0) {
				emptyView.preview().frame(height: 100).padding(.bottom, 20)
			}
			.preferredColorScheme(.light)
		}
	}
}
#endif
