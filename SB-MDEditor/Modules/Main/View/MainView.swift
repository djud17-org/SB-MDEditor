//
//  MainView.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 20.04.2023.
//

import UIKit

final class MainView: UIView {
	// MARK: - Parameters

	private let dataSections: [Section]

	// MARK: - UI Elements

	private lazy var collectionView = makeCollectionView()

	// MARK: - Inits

	init(layoutSections: [Section]) {
		self.dataSections = layoutSections
		super.init(frame: .zero)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public funcs

	/// Функция для установки источника данных коллекции
	/// - Parameter dataSource: источник данных
	func setupCollectionViewDataSource(dataSource: UICollectionViewDataSource) {
		collectionView.dataSource = dataSource
	}

	/// Функция для установки делегата коллекции
	/// - Parameter delegate: делегат
	func setupCollectionViewDelegate(delegate: UICollectionViewDelegate) {
		collectionView.delegate = delegate
	}

	// MARK: - Private funcs

	private func setupView() {
		backgroundColor = Theme.color(usage: .white)

		addSubview(collectionView)
	}

	private func setupLayout() {
		collectionView.makeConstraints { make in
			[
				make.topAnchor.constraint(equalTo: topAnchor),
				make.leftAnchor.constraint(equalTo: leftAnchor),
				make.rightAnchor.constraint(equalTo: rightAnchor),
				make.bottomAnchor.constraint(equalTo: bottomAnchor)
			]
		}
	}
}

// MARK: - UI setup

private extension MainView {
	func makeCollectionView() -> UICollectionView {
		let layout = createLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(models: [
			RecentFileCell.RecentFileCellModel.self,
			MenuItemCell.MenuItemCellModel.self
		])

		return collectionView
	}

	func createLayout() -> UICollectionViewCompositionalLayout {
		UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
			guard let self = self else { return nil }

			let section = self.dataSections[sectionIndex]

			let layoutSection: NSCollectionLayoutSection
			switch section {
			case .recentFiles:
				layoutSection = self.createRecentFilesLayout()
			case .menu:
				layoutSection = self.createMenuItemLayout()
			}

			return layoutSection
		}
	}

	func createRecentFilesLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.33),
			heightDimension: .fractionalHeight(1)
		)
		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = Appearance.itemInsets

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(0.23)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPaging

		return layoutSection
	}

	func createMenuItemLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = Appearance.itemInsets

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(50)
		)
		let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: Theme.spacing(usage: .standard),
			bottom: 0,
			trailing: Theme.spacing(usage: .standard)
		)

		return layoutSection
	}
}

// MARK: - Appearance
private extension MainView {
	enum Appearance {
		static let itemInsets = NSDirectionalEdgeInsets(
			top: Theme.spacing(usage: .standardHalf),
			leading: Theme.spacing(usage: .standardHalf),
			bottom: Theme.spacing(usage: .standardHalf),
			trailing: Theme.spacing(usage: .standardHalf)
		)
	}
}
