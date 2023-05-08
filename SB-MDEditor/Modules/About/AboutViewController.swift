import UIKit
import WebKit

protocol IAboutViewController: AnyObject {
	/// Рендрит вьюмодель
	func render(viewModel: AboutModel.ViewData)
}

final class AboutViewController: UIViewController {
	// MARK: - Parameters

	private let interactor: IAboutInteractor
	private let router: IAboutRouter

	private lazy var webView: WKWebView = makeWebView()

	// MARK: - Inits

	init(
		interactor: IAboutInteractor,
		router: IAboutRouter
	) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		applyStyle()

		interactor.viewIsReady()
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewData) {
		view = webView
		let htmlContent = MarkdownToHtmlConverter().convert(viewModel.fileContents)
		webView.loadHTMLString(htmlContent, baseURL: nil)
	}
}

// MARK: - Action
private extension AboutViewController {
	@objc func returnToMainScreen() {
		router.navigate(.toSimpleMainModule)
	}
}

// MARK: - UI
private extension AboutViewController {
	func setup() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(returnToMainScreen)
		)
	}

	func applyStyle() {
		title = Appearance.title
		view.backgroundColor = Theme.color(usage: .white)
	}
}

// MARK: - UI make
func makeWebView() -> WKWebView {
	let webview = WKWebView()
	webview.allowsBackForwardNavigationGestures = true
	return webview
}

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let title = "About"
	}
}
