import UIKit

extension Theme {
	// MARK: - Images
	enum ImageAsset: String {
		case aboutMenuIcon
		case newFileMenuIcon
		case openMenuIcon

		case emptyPlaceholder
		case recentFilesPlaceholder

		case addDirectoryIcon
		case addFileIcon
		case backIcon
	}

	static func image(kind: ImageAsset) -> UIImage {
		return UIImage(named: kind.rawValue) ?? .actions // swiftlint:disable:this image_name_initialization
	}
}
