//
//  MainSimpleViewController.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 30.04.2023.
//

import UIKit

enum Event {
	case openDoc
	case createDoc
	case about

	func menuTitleValue() -> String {
		switch self {
		case .openDoc:
			return "Open"
		case .createDoc:
			return "New"
		case .about:
			return "About"
		}
	}

	func menuIconValue() -> UIImage {
		let image: UIImage
		switch self {
		case .openDoc:
			image = Theme.image(kind: .openMenuIcon)
		case .createDoc:
			image = Theme.image(kind: .newFileMenuIcon)
		case .about:
			image = Theme.image(kind: .aboutMenuIcon)
		}
		return image
	}
}

final class MainSimpleViewController: UIViewController {
	let router: IMainSimpleRoutingLogic

	// MARK: - UI
	private lazy var openDocButton: UIButton = makeButtonByEvent(.openDoc)
	private lazy var createDocButton: UIButton = makeButtonByEvent(.createDoc)
	private lazy var aboutButton: UIButton = makeButtonByEvent(.about)

	// MARK: - Init

	init(router: IMainSimpleRoutingLogic) {
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		applyStyle()
		setupConstraints()
	}
}

// MARK: - Action
private extension MainSimpleViewController {
	private func acitonByEvent(_ event: Event) -> (() -> Void) {
		switch event {
		case .openDoc:
			return { self.router.navigate(.toOpenDoc(File.makePrototypeDir())) }
		case .createDoc:
			return { print("Создать документ") }
		case .about:
			return { self.router.navigate(.toAbout) }
		}
	}
}

// MARK: - UI
private extension MainSimpleViewController {
	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .white)
	}
	func setupConstraints() {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = Theme.spacing(usage: .standard2)
		stack.alignment = .leading

		[
			openDocButton,
			createDocButton,
			aboutButton
		].forEach { stack.addArrangedSubview($0) }

		view.addSubview(stack)
		stack.makeEqualToSuperviewCenter()
	}
}

// MARK: - UI make
private extension MainSimpleViewController {
	func makeButtonByEvent(_ event: Event) -> UIButton {
		let button = UIButton()

		button.setImage(event.menuIconValue(), for: .normal)
		button.setTitle(event.menuTitleValue(), for: .normal)
		button.setTitleColor(Theme.color(usage: .main), for: .normal)

		button.event = acitonByEvent(event)

		return button
	}
}

// MARK: - Appearance
private extension MainSimpleViewController {
	enum Appearance {
		static let title = "MD redactor"
	}
}

// MARK: - Button event

extension UIButton {
	private enum AssociatedKeys {
		static var event = "event"
	}

	var event: (() -> Void)? {
		get {
			return objc_getAssociatedObject(self, &AssociatedKeys.event) as? () -> Void
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.event, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
		}
	}

	@objc private func onButtonTapped() {
		event?()
	}
}
