//
//  UICollectionView+Extensions.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 21.04.2023.
//

import UIKit

extension UICollectionView {

	/// Функция для создания переиспользуемой ячейки
	/// - Parameters:
	///   - model: Модель данных
	///   - indexPath: Индекс ячейки
	/// - Returns: Сконфигурированную ячейку
	func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = String(describing: type(of: model).cellAnyType)
		let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
		model.setupAny(cell: cell)

		return cell
	}

	/// Функция для регистрации переиспользуемой ячейки
	/// - Parameter models: Модель данных
	func register(models: [CellViewAnyModel.Type]) {
		for model in models {
			let identifier = String(describing: model.cellAnyType)
			self.register(model.cellAnyType, forCellWithReuseIdentifier: identifier)
		}
	}
}
