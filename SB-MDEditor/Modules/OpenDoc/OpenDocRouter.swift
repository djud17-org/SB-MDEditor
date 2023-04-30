//
//  OpenDocRouter.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 29.04.2023.
//

import UIKit

protocol IOpenDocRoutingLogic: MainRouting {}

final class OpenDocRouter: NSObject, IOpenDocRoutingLogic {
	weak var view: IRootViewController?
}
