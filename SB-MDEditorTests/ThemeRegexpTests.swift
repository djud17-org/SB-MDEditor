import XCTest
@testable import SB_MDEditor

final class ThemeRegexpTests: XCTestCase {

	func test_regexp_paragraph_shouldBeTrue() {
		let text = "# Paragraph"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .paragraph))

		XCTAssertNotNil(result, "Неверное выражение для Абзаца")
	}

	func test_regexp_header_shouldBeTrue() {
		let text = "# Paragraph"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .header))

		XCTAssertNotNil(result, "Неверное выражение для Заголовка")
	}

	func test_regexp_pnumberedList_shouldBeTrue() {
		let text =
"""
1. Один
2. Два
3. Три
"""

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .numberedList))

		XCTAssertNotNil(result, "Неверное выражение для Нумерованного списка")
	}

	func test_regexp_unorderedList_shouldBeTrue() {
		let text =
"""
- Один
- Два
- Три
"""

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .unorderedList))

		XCTAssertNotNil(result, "Неверное выражение для Ненумерованного списка")
	}

	func test_regexp_link_shouldBeTrue() {
		let text = "[Markdown Guide](https://www.markdownguide.org)"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .link))

		XCTAssertNotNil(result, "Неверное выражение для Ссылки")
	}

	func test_regexp_boldText_shouldBeTrue() {
		let text = "**boldText**"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .boldText))

		XCTAssertNotNil(result, "Неверное выражение для Жирного текста")
	}

	func test_regexp_italicText_shouldBeTrue() {
		let text = "*italicText*"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .italicText))

		XCTAssertNotNil(result, "Неверное выражение для Курсивного текста")
	}

	func test_regexp_cite_shouldBeTrue() {
		let text = "> This is cite"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .cite))

		XCTAssertNotNil(result, "Неверное выражение для Цитаты")
	}

	func test_regexp_inlineCode_shouldBeTrue() {
		let text = "`This is code inline`"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .inlineCode))

		XCTAssertNotNil(result, "Неверное выражение для Кода в строке")
	}

	func test_regexp_blockCode_shouldBeTrue() {
		let text =
"""
```swift
let a = 1
print(a)
```
"""

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .blockCode))

		XCTAssertNotNil(result, "Неверное выражение для Блока кода")
	}

	func test_regexp_horizontalLine_shouldBeTrue() {
		let text = "---"

		let result = regexp(text: text, with: Theme.MarkdownRegexp.pattern(usage: .horizontalLine))

		XCTAssertNotNil(result, "Неверное выражение для Кода в строке")
	}
}

	private extension ThemeRegexpTests {
		func regexp(text: String, with pattern: String) -> NSTextCheckingResult? {
			let range = NSRange(text.startIndex..., in: text)
			// swiftlint:disable force_try
			let regex = try! NSRegularExpression(pattern: pattern)
			let result = regex.firstMatch(in: text, range: range)

			return result
		}
	}
