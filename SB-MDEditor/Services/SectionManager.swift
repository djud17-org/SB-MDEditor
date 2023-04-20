//
//  SectionManager.swift
//  SB-MDEditor
//
//  Created by Давид Тоноян  on 21.04.2023.
//

import Foundation

enum Section {
	case recentFiles
	case menu
}

protocol ISectionManager {

	/// Функция позволяет получить доступные секции для коллекции.
	/// - Returns: массив секций.
	func getSections() -> [Section]
}

/// Менеджер секций для коллекции
final class SectionManager: ISectionManager {
	private let sections: [Section] = [.recentFiles, .menu]

	func getSections() -> [Section] {
		sections
	}
}
