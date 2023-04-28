//
//  Theme+Constants.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 27.04.2023.
//
import Foundation

extension Theme {
	enum Constansts {
		// swiftlint:disable:next closure_body_length
		static let baseFilePaths: [File] = {
			var newList: [File] = []

			if let documents = FileManager.default.urls(
				for: .documentDirectory,
				in: .userDomainMask
			).first {
				let path = documents.path
				newList.append(
					.init(
						name: "** Документы **",
						path: path,
						ext: "",
						size: .zero,
						filetype: .directory,
						creationDate: Date(),
						modificationDate: Date()
					)
				)
			}

			if let bundle = Bundle.main.resourcePath {
				let path = bundle + "/MD_Bandle"
				newList.append(
					.init(
						name: "** Бандл **",
						path: path,
						ext: "",
						size: .zero,
						filetype: .directory,
						creationDate: Date(),
						modificationDate: Date()
					)
				)
			}

			return newList
		}()

		static let aboutFilePath: String = {
			if let bundle = Bundle.main.resourcePath {
				let path = bundle + "/About.md"
				return path
			}
			return ""
		}()

		static let exts = ["md"]
	}
}
