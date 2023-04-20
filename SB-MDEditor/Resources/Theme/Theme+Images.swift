import UIKit

extension Theme {
	// MARK: - Images
	enum ImageAsset: String {
		case aboutMenuIcon, newFileMenuIcon, openMenuIcon
		case emptyPlaceholder, recentFilesPlaceholder
	}

	static func image(kind: ImageAsset) -> UIImage {
		return UIImage(named: kind.rawValue) ?? .actions // swiftlint:disable:this image_name_initialization
	}
}
