//
//  Theme+DateFormatter.swift
//  Swift-Base
//
//  Created by SERGEY SHLYAKHIN on 18.04.2023.
//

import Foundation

extension Theme {
	// MARK: - DateFormatter
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .none
		return formatter
	}()
}
