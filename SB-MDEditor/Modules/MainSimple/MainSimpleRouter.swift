//
//  MainSimpleRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 01.05.2023.
//

import UIKit

protocol IMainSimpleRoutingLogic: MainRouting {}

final class MainSimpleRouter: NSObject, IMainSimpleRoutingLogic {
	weak var view: IRootViewController?
}
