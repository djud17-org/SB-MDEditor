//
//  EmptyView.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 20.04.2023.
//

import UIKit

final class EmptyView: UIView {
	private lazy var emptyImageView = makeEmptyImageView()
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

extension EmptyView {
	@discardableResult
	func update(with data: MDViewData) -> Self {
		emptyImageView.image = data.image
		emptyTextLabel.text = data.message
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
		return image
	}

	func makeEmptyTextLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.color(usage: .gray)
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
		stackContainer.spacing = Theme.spacing(usage: .standard2)

		let insets = UIEdgeInsets(
			top: Theme.spacing(usage: .standard),
			left: Theme.spacing(usage: .standard2),
			bottom: Theme.spacing(usage: .standard2),
			right: Theme.spacing(usage: .standard2)
		)

		[
			emptyImageView,
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
		emptyView.update(with: MDViewData.EmptyViewData)
		return Group {
			VStack(spacing: 0) {
				emptyView.preview().frame(height: 100).padding(.bottom, 20)
			}
			.preferredColorScheme(.light)
		}
	}
}
#endif
