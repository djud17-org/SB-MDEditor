//
//  Theme+Regexp.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 09.05.2023.
//

import Foundation

enum MarkdownRegexp: String {
	case paragraph
	case header
	case numberedList
	case unorderedList
	case link
	case boldText
	case italicText
	case cite
	case inlineCode
	case blockCode
	case horizontalLine

	static func pattern(usage: MarkdownRegexp) -> String {
		let pattern: String

		switch usage {
		case .paragraph:
			pattern = "^(.*)" // Пока не знаю как сделать лучше
		case .header:
			pattern = #"(^#{1,6} )"#
		case .numberedList:
			pattern = #"((^(\d+\.)(\s)(.*)(?:$)?)+)"#
		case .unorderedList:
			pattern = #"((^(\W{1})(\s)(.*)(?:$)?)+)"#
		case .link:
			pattern = #"(\[.*\])(\((http)(?:s)?:\/\/.*)"#
		case .boldText:
			pattern = #"\*\*(.*?)\*\*"#
		case .italicText:
			pattern = #"\*(.*?)\*"#
		case .cite:
			pattern = #"(^\>{1}.*$)"#
		case .inlineCode:
			pattern = #"((\`{1})(.*)(\`{1}))"#
		case .blockCode:
			pattern = #"(^\`{3}([\S]+)?\n([\s\S]+)\n\`{3})"#
		case .horizontalLine:
			pattern = #"((\=|\-|\*){3})"#
		}

		return pattern
	}
}
