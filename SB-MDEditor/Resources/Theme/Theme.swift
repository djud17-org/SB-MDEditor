import UIKit

enum Theme {
	// MARK: - Fonts
	enum FontStyle {
		case preferred(style: UIFont.TextStyle)
		case largeTitle
		case title
		case smallTitle
		case commandTitle
		case footnote
		case caption
	}

	static func font(style: FontStyle) -> UIFont {
		let customFont: UIFont

		switch style {
		case let .preferred(style: style):
			customFont = UIFont.preferredFont(forTextStyle: style)
		case .largeTitle:
			customFont = UIFont.preferredFont(forTextStyle: .largeTitle)
		case .title:
			customFont = UIFont.preferredFont(forTextStyle: .title1)
		case .smallTitle:
			customFont = UIFont.preferredFont(forTextStyle: .title3)
		case .commandTitle:
			customFont = UIFont.preferredFont(forTextStyle: .headline)
		case .footnote:
			customFont = UIFont.preferredFont(forTextStyle: .footnote)
		case .caption:
			customFont = UIFont.preferredFont(forTextStyle: .caption1)
		}

		return customFont
	}
}
