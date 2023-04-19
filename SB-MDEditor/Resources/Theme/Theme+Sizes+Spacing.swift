//
//  Theme+Sizes+Spacing.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 18.04.2023.
//

import UIKit

extension Theme {
	// MARK: - Spacing
	enum Spacing {
		case standard
		case standard2
		case standardHalf
		case standard4
	}

	static func spacing(usage: Spacing) -> CGFloat {
		let customSpacing: CGFloat

		switch usage {
		case .standard:
			customSpacing = 8
		case .standard2:
			customSpacing = 16
		case .standardHalf:
			customSpacing = 4
		case .standard4:
			customSpacing = 32
		}

		return customSpacing
	}

	// MARK: - Size
	enum Size {
		case cornerRadius
	}

	static func size(kind: Size) -> CGFloat {
		let customSize: CGFloat

		switch kind {
		case .cornerRadius:
			customSize = 10
		}

		return customSize
	}
}
