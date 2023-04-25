// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable all

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Menu {
    internal static let aboutMenuIcon = ImageAsset(name: "aboutMenuIcon")
    internal static let newFileMenuIcon = ImageAsset(name: "newFileMenuIcon")
    internal static let openMenuIcon = ImageAsset(name: "openMenuIcon")
  }
  internal enum Placeholders {
    internal static let emptyPlaceholder = ImageAsset(name: "EmptyPlaceholder")
    internal static let recentFilesPlaceholder = ImageAsset(name: "recentFilesPlaceholder")
  }
  internal static let icBack = ImageAsset(name: "ic_back")
  internal static let icBook = ImageAsset(name: "ic_book")
  internal static let icCompress = ImageAsset(name: "ic_compress")
  internal static let icFile = ImageAsset(name: "ic_file")
  internal static let icFileCode = ImageAsset(name: "ic_file_code")
  internal static let icFolder = ImageAsset(name: "ic_folder")
  internal static let icGrid = ImageAsset(name: "ic_grid")
  internal static let icMemory = ImageAsset(name: "ic_memory")
  internal static let icNext = ImageAsset(name: "ic_next")
  internal static let icOcr = ImageAsset(name: "ic_ocr")
  internal static let icPause = ImageAsset(name: "ic_pause")
  internal static let icPlay = ImageAsset(name: "ic_play")
  internal static let icResume = ImageAsset(name: "ic_resume")
  internal static let icStop = ImageAsset(name: "ic_stop")
  internal static let icTrash = ImageAsset(name: "ic_trash")

  internal static let allColors: [ColorAsset] = [
    accentColor,
  ]
  internal static let allImages: [ImageAsset] = [
    Menu.aboutMenuIcon,
    Menu.newFileMenuIcon,
    Menu.openMenuIcon,
    Placeholders.emptyPlaceholder,
    Placeholders.recentFilesPlaceholder,
    icBack,
    icBook,
    icCompress,
    icFile,
    icFileCode,
    icFolder,
    icGrid,
    icMemory,
    icNext,
    icOcr,
    icPause,
    icPlay,
    icResume,
    icStop,
    icTrash,
  ]
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}

// swiftlint:enable all