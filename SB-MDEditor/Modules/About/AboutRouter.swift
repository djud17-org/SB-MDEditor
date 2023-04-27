//
//  AboutRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 27.04.2023.
//

import UIKit

protocol AboutRoutingLogic: MainRouting {}

final class AboutRouter: NSObject, AboutRoutingLogic {
	weak var view: IRootViewController?
}
