//
//  MainSimpleRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 01.05.2023.
//

import UIKit

protocol IMainSimpleRoute: MainRouting {}

final class MainSimpleRouter: IMainSimpleRoute {
	weak var view: IRootViewController?
}
