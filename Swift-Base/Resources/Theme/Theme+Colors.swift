import UIKit

extension Theme {
	// MARK: - Colors
	private enum FlatColor {
		enum DayNight {
			static let black = UIColor(hex: 0x1A1B22)
			static let white = UIColor(hex: 0xFFFFFF)
			static let gray = UIColor(hex: 0xAEAFB4)
			static let lightGray = UIColor(hex: 0xE6E8EB)
			static let backgroundDay = UIColor(hex: 0xE6E8EB).withAlphaComponent(30.0)
			static let backgroundNight = UIColor(hex: 0x414141).withAlphaComponent(85.0)
			static let red = UIColor(hex: 0xF56B6C)
			static let blue = UIColor(hex: 0x3772E7)
		}
	}

	enum Color {
		case main
		case accent
		case background
		case attention
		case white
		case black
		case gray
		case lightGray
	}

	static func color(usage: Color) -> UIColor {
		let customColor: UIColor

		switch usage {
		case .main:
			customColor = UIColor.color(
				light: FlatColor.DayNight.black,
				dark: FlatColor.DayNight.white
			)
		case .accent:
			customColor = FlatColor.DayNight.blue
		case .background:
			customColor = UIColor.color(
				light: FlatColor.DayNight.backgroundDay,
				dark: FlatColor.DayNight.backgroundNight
			)
		case .attention:
			customColor = FlatColor.DayNight.red
		case .white:
			customColor = UIColor.color(
				light: FlatColor.DayNight.white,
				dark: FlatColor.DayNight.black
			)
		case .black:
			customColor = UIColor.color(
				light: FlatColor.DayNight.black,
				dark: FlatColor.DayNight.white
			)
		case .gray:
			customColor = FlatColor.DayNight.gray
		case .lightGray:
			customColor = FlatColor.DayNight.lightGray
		}

		return customColor
	}
}
