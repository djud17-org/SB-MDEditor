//
//  MarkdownToHtmlConverter.swift
//  SB-MDEditor
//
//  Created by CHURILOV DMITRIY on 07.05.2023.
//

import Foundation

protocol IMarkdownToHtmlConverter {
	func convert(_ text: String) -> String
}

final class MarkdownToHtmlConverter: IMarkdownToHtmlConverter {
	func convert(_ text: String) -> String {
		let lines = text.components(separatedBy: .newlines)
		var html = [String]()

		lines.forEach { line in
			if let header = parseHeader(text: line) {
				html.append(header)
			} else if let paragraph = parseParagraph(text: line) {
				html.append(paragraph)
			}
		}
		return makeHtml(html.joined())
	}
}

private extension MarkdownToHtmlConverter {
	func makeHtml(_ text: String) -> String {
		return "<!DOCTYPE html><html><head><style> body {font-size: 300%;}</style></head><body>\(text)</body></html>"
	}

	func parseHeader(text: String) -> String? {
		let pattern = #"^#{1,6} "#

		if let headerRange = text.range(of: pattern, options: .regularExpression) {
			let headerText = text[headerRange.upperBound...]
			let headerLevel = text.filter { $0 == "#" }.count
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}
		return nil
	}

	func parseParagraph(text: String) -> String? {
		return "<p>\(text)</p>"
	}
}
