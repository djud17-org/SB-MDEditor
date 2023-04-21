//
//  MainView.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 20.04.2023.
//

import UIKit

final class MainView: UIView {
	// MARK: - UI Elements

	private var collectionView: UICollectionView?

	// MARK: - Inits

	init(layoutSections: [Section]) {
		super.init(frame: .zero)

		setupCollectionView(for: layoutSections)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public funcs

	/// Функция для установки источника данных коллекции
	/// - Parameter dataSource: источник данных
	func setupCollectionViewDataSource(dataSource: UICollectionViewDataSource) {
		collectionView?.dataSource = dataSource
	}

	/// Функция для установки делегата коллекции
	/// - Parameter delegate: делегат
	func setupCollectionViewDelegate(delegate: UICollectionViewDelegate) {
		collectionView?.delegate = delegate
	}

	// MARK: - Private funcs

	private func setupView() {
		guard let collectionView = collectionView else { return }

		backgroundColor = Theme.color(usage: .white)

		addSubview(collectionView)

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leftAnchor.constraint(equalTo: leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	private func setupCollectionView(for sections: [Section]) {
		let layout = createLayout(for: sections)
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView?.translatesAutoresizingMaskIntoConstraints = false
		collectionView?.register(models: [
			RecentFileCell.RecentFileCellModel.self,
			MenuItemCell.MenuItemCellModel.self
		])
	}

	private func createLayout(for sections: [Section]) -> UICollectionViewCompositionalLayout {
		return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
			guard let self = self else { return nil }

			let section = sections[sectionIndex]

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

	private func createRecentFilesLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.33),
			heightDimension: .fractionalHeight(1)
		)
		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(0.23)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPaging

		return layoutSection
	}

	private func createMenuItemLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(50)
		)
		let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

		return layoutSection
	}
}
