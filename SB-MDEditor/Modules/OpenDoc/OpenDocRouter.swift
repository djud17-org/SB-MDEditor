//
//  OpenDocRouter.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 29.04.2023.
//

import UIKit

protocol IOpenDocRoutingLogic: MainRouting {
	// func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol IOpenDocDataPassing {
	var dataStore: IOpenDocDataStore? { get }
}

final class OpenDocRouter: NSObject, IOpenDocRoutingLogic, IOpenDocDataPassing {
	weak var view: IRootViewController?

	weak var viewController: OpenDocViewController?
	var dataStore: IOpenDocDataStore?

	// MARK: Routing

	// MARK: Navigation

	// func navigateToSomewhere(source: MainViewController, destination: SomewhereViewController)
	// {
	//  source.show(destination, sender: nil)
	// }

	// MARK: Passing data

	// func passDataToSomewhere(source: MainDataStore, destination: inout SomewhereDataStore)
	// {
	//  destination.name = source.name
	// }
}
