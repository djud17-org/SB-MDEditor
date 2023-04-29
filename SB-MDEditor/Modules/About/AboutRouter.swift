//
//  AboutRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 27.04.2023.
//

import UIKit

protocol IRoutingLogic: MainRouting {}

final class AboutRouter: NSObject, IRoutingLogic {
	weak var view: IRootViewController?
}
