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

	private var webView: WKWebView! // swiftlint:disable:this implicitly_unwrapped_optional

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
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

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

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let title = "About"
	}
}

// MARK: - Navigation Delegate
extension AboutViewController: WKNavigationDelegate {}
