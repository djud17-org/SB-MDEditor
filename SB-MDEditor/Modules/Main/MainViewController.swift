//
//  MainViewController.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 18.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainDisplayLogic: AnyObject {
	func displaySomething(viewModel: Main.Something.ViewModel)
}

final class MainViewController: UIViewController, MainDisplayLogic {
	// MARK: - Parameters

	private let interactor: MainBusinessLogic
	private let router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)
	private let sectionManager: ISectionManager

	// MARK: - Inits

	init(
		interactor: MainBusinessLogic,
		router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing),
		dep: IMainModuleDependency
	) {
		self.interactor = interactor
		self.router = router
		self.storage = dep.storage
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: ViewController lifecycle

	override func loadView() {
		let sections = sectionManager.getSections()
		let mainView = MainView(layoutSections: sections)
		self.view = mainView

		mainView.setupCollectionViewDelegate(delegate: self)
		mainView.setupCollectionViewDataSource(dataSource: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
	}

	// MARK: Do something
	func doSomething() {
		let request = Main.Something.Request()
		interactor?.doSomething(request: request)
	}

	func displaySomething(viewModel: Main.Something.ViewModel) {}
}

// MARK: - UI setup
private extension MainViewController {
	func setupView() {
		title = L10n.Main.title
		view.backgroundColor = Theme.color(usage: .background)
	}
}

// MARK: - CollectionView dataSource extension

extension MainViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		sectionManager.getSections().count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let sections = sectionManager.getSections()

		switch sections[section] {
		case .recentFiles:
			return 10 // заменить данные
		case .menu:
			return 5 // заменить данные
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let sections = sectionManager.getSections()

		let model: CellViewAnyModel
		switch sections[indexPath.section] {
		case .recentFiles:
			// заменить данные
			model = RecentFileCell.RecentFileCellModel(fileCoverColor: .brown, fileName: "Test")
		case .menu:
			// заменить данные
			model = MenuItemCell.MenuItemCellModel(itemIcon: .init(systemName: "menucard"), itemName: "Открыть")
		}

		return collectionView.dequeueReusableCell(withModel: model, for: indexPath)
	}
}

// MARK: - CollectionView delegate extension

extension MainViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}

// MARK: - SwiftUI preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewProvider3: PreviewProvider {
	static var previews: some View {
		let rootViewController = RootViewController()
		let di = Di(rootVC: rootViewController)
		rootViewController.factory = di
		// swiftlint:disable:next force_unwrapping
		let viewController = rootViewController.factory!.makeMainModule().viewController
		return viewController.preview()
	}
}
#endif
