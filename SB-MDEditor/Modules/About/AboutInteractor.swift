//
//  AboutInteractor.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 26.04.2023.
//

import UIKit

protocol AboutBusinessLogic {
	func doSomething(request: Main.Something.Request)
}

final class AboutInteractor: AboutBusinessLogic, MainDataStore {
	//	private let presenter: AboutPresentationLogic

	init(presenter: MainPresentationLogic, worker: MainWorker) {
		//		self.presenter = presenter
	}

	// MARK: Do something

	func doSomething(request: Main.Something.Request) {
		//		worker.doSomeWork()

		//		let response = Main.Something.Response()
		//		presenter.presentSomething(response: response)
	}
}

// MARK: - Appearance
private extension AboutViewController {
	enum Appearance {
		static let aboutFilePath = Bundle.main.resourcePath! + "/About.md"
	}
}
