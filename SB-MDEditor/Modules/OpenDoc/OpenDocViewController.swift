import UIKit

protocol IOpenDocViewController: AnyObject {
	func render(viewModel: OpenDocModel.Something.ViewModel)
}

final class OpenDocViewController: UITableViewController {
	private let interactor: IOpenDocInteractor
	private let router: (NSObjectProtocol & IOpenDocRoutingLogic & IOpenDocDataPassing)
	private var viewModel: OpenDocModel.Something.ViewModel = .init(files: [])

	var path = ""

	init(interactor: IOpenDocInteractor, router: NSObjectProtocol & IOpenDocRoutingLogic & IOpenDocDataPassing) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override	func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor.viewIsReady()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupTableView()
		interactor.viewIsReady()
	}
	private func setupView() {
		navigationItem.backBarButtonItem = UIBarButtonItem(
			title: "",
			style: .plain,
			target: nil,
			action: nil
		)
		navigationController?.navigationBar.barTintColor = Theme.color(usage: .lightGray)
	}

	private func setupTableView() {
		tableView.separatorStyle = .singleLine
		tableView.register(OpenDocCell.self, forCellReuseIdentifier: OpenDocCell.identifier)
	}
}

extension OpenDocViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model: CellViewAnyModel
		let file = viewModel.files[indexPath.row]

		model = OpenDocCellModel(
			name: file.name,
			fieldFileAttributes: file.fileAttributes,
			fieldImage: file.fileImage
		)

		return tableView.dequeueReusableCell(withModel: model, for: indexPath)
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let file = viewModel.files[indexPath.row]

		interactor.didFileSelected(at: indexPath)

		// Здесь попытка реализовать переходы, пока работает очень криво
		let viewController = OpenDocViewController(interactor: interactor, router: router)
		viewController.title = file.name
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModel.Something.ViewModel) {
		self.viewModel = viewModel
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct OpenDocViewProvider: PreviewProvider {
	static var previews: some View {
		let rootViewController = RootViewController()
		let di = Di(rootVC: rootViewController)
		rootViewController.factory = di
		// swiftlint:disable:next force_unwrapping
		let viewController = rootViewController.factory!.makeOpenDocModule().viewController
		return viewController.preview()
	}
}
#endif
