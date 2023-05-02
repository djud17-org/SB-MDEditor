//
//  CreateDocRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 02.05.2023.
//

import UIKit

protocol ICreateDocRouter: MainRouting {}

final class CreateDocRouter: ICreateDocRouter {
	weak var view: IRootViewController?
}
