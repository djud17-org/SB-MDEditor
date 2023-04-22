
# Руководство по оформлению и требования к тестам для языка Swift

```toc
```

При написании руководства использованы следующие материалы:

- [Google's Swift Style Guide](https://google.github.io/swift/)
- [Raywenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- [Airbnb Swift Style Guide](https://github.com/airbnb/swift)

## Требования

- версия **Swift 5**, **Xcode 14**

## Основные моменты

- при написании кода рекомендуется руководствоваться [*Protocol-Oriented Programming*](https://habr.com/ru/post/358804/);
- код должен соответствовать *Apple Swift* [*API Design Guidelines*](https://swift.org/documentation/api-design-guidelines/#naming);
- длина строки не должна превышать **120 символов**;
- длина класса или структуры не должна превышать **400 строк**;
- длина функции или метода не должна превышать **40 строк**;
- длина файла не должна превышать **500 строк** (исключение - ресурсы, локализация); 
- кодировка, используемая в текстовых файлах - **UTF8**;
- отступ слева устанавливается только с помощью **табов**.

![[SSG-1678115567371.png|900]]
Для настройки указанных выше параметров перейдите в **Xcode -> Preferences -> Text Editing -> Indentation**.

![[SSG-1678115634961.png|900]]
Кроме того в **Xcode → Preferences → Text Editing → Editing** необходимо установить флаги для параметра: **Automatically trim trailing whitespace**

## Требования к тестам

### Структура файла с тестами

`Snapshot`-тесты и `unit`-тесты описываются в разных файлах: `ClassSnapshots` и `ClassTests`, например: `TextFieldViewSnapshots`, `TextFieldViewTests`. В файле с тестами определяется только один тестовый класс.

В теле тестового класса располагаются:
- тестовые методы;
- переопределенные методы `XCTestCase`;
- хранимые свойства - при необходимости.
Остальные свойства и методы описываются в `extension`.

Файлы с тестами разбиваются на смысловые блоки, такие блоки помечаются соответствующими метками:
- для свойств/методов, предназначенных для формирования тестовых данных, используется метка: `MARK: - TestData`;
- для дополнительных приватных методов: `MARK: - Private`;
- другие метки - на усмотрение автора.

```swift
class TextFieldViewTests: XCTestCase {

	private let textField = TextFieldView()

	func test_didBeginEditing_shouldCallViewCommand() {
		// ...
	}
}

// MARK: - TestData

private extension TextFieldViewTests {
	// ...
}

// MARK: - Private 

private extension TextFieldViewTests {
	// ...
}
```

**Примечание:**
- для всех членов `XCTest`, не являющихся участниками тестирования, устанавливается уровень доступа `private`.

### Объявление тестовых модулей

- импорт модулей/подмодулей, а также отдельных объявлений (`class`, `enum`, `func`, `struct`, `var`) не тестируется;
- тестируются модули, импортированные с помощью `@testable` (присутствуют только в тестовых источниках);
- импорт тестируемого модуля располагается после остальных необходимых импортов.

```swift
import CoreLocation
import MyThirdPartyModule
import SpriteKit
import UIKit

import func Darwin.C.isatty

@testable import MyModuleUnderTest
```

### Именование тестов

#### `Unit`-тесты

Имя `unit`-теста составное и содержит **4** части:

```swift
func test_incrementScanCount_withInProgressItemModel_shouldBeFail()
```

1. `test` - начало тестовой функции;
2. `incrementScanCount` - тестируемая функция;
3. `withInProgressItemModel` - параметры тестирования (если нужны);
4. `shouldBeFail` - ожидаемый результат теста.

Составные части для читаемости отделяются нижним подчёркиванием: `_`.

```swift
// ✅ Принимается

func test_initBarcode_withInvalidInputString_shouldBeNil()
func test_incrementScanCount_withSurpluseItemModel_shouldBeFail()
func test_incrementScanCount_withSurpluseItemModel_shouldBeSuccess()
```

```swift
// ❌ Не принимается

func testInitBarcode_withInvalidInputString_shouldBeNil()
func testReadBarcodePrice()
func testEmptyStatus()
```

#### `Snapshot`-тесты

Имя `snapshot`-теста составное и содержит **4** части:

```swift
func test_renderFocused_withTextError_style1()
```

1. `test` - начало тестовой функции;
2. `renderFocused` - тестируемая функция или состояние;
	- при тестировании визуального отображения используется ключевое слово `render`;
	- при тестировании моделей данных - `compare`;
3. `withTextError` - параметры тестирования, конфигурация (если нужны);
4. `style1` - дополнительный параметр, позволяющий уточнить тестируемое состояние.

Если для теста требуется большое число параметров, то следует использовать наиболее емкое описание конфигурации в третьей части имени теста, в крайнем случае допустимо использование цифровой идентификации, например: `configuration1`.

Составные части для читаемости отделяются нижним подчёркиванием: `_`. 

```swift
// ✅ Принимается

func test_renderFocused_withTextError_style1()
func test_renderFocused_withNilText_style1()
func test_renderInitial_style1()
func test_renderFocused_configuration1_style1()
```

```swift
// ❌ Не принимается

func test_focusedWithTextError_style1()
func testRender()
func test_empty()
func test_renderFocused_withWhiteTextColorAndLongInputTextAndWarningIndicator_style1()
```

### Оформление тестов

При оформлении тестов каждый логический блок `arrange`, `act`, `assert` отделяется пустой строкой, при необходимости указываются соответствующие метки для визуального разделения теста и улучшения его восприятия.

```swift
// ✅ Принимается

func test_loadView_shouldHaveCorrectTitle() {

	// arrange
	let sut = makeSUT()

	// act
	sut.loadViewIfNeeded()

	// assert
	XCTAssertEqual(
		sut.title,
		L10n.SearchViewController.title,
		"Установлен неверный заголовок"
	)
}
```

```swift
// ❌ Не принимается

func test_loadView_shouldHaveCorrectTitle() {
	let sut = makeSUT()
	sut.loadViewIfNeeded()
	XCTAssertEqual(
		sut.title,
		L10n.SearchViewController.title,
		"Установлен неверный заголовок"
	)
}
```

Все `XCTAssert`, а также вызовы `XCTFail`, **должны** содержать поясняющее сообщение (параметр `message`), уточняющее что именно пошло не так.

**Исключение:** 
- поясняющее сообщение опускается для проверок в `snapshot`-тестах.

```swift
// ✅ Принимается

// MARK: - Unit

XCTAssertEqual(expectedResult, macAddress, "Ошибка SDK принтера - не удалось подключиться к устройству")

XCTAssertNil(expectedResult, "При ошибке подключения принтера должны быть получены сведения об этой ошибке")

XCTAssertTrue(success, "Ошибка, не удалось отправить данные на печать")

// MARK: - Snapshot

assertView(view: textFieldView)
```

```swift
// ❌ Не принимается

XCTAssertEqual(expectedResult, macAddress)

XCTAssertNil(expectedResult)

XCTAssertNotNil(sut.titleLabel, "TitleLabel nil")
```

Следует использовать конкретные сопоставители `XCTest` (`XCTAssertNil`, `XCTAssertTrue` и другие) вместо `XCTAssertEqual`/`XCTAssertNotEqual`.

```swift
// ✅ Принимается

XCTAssertTrue(success, "Ошибка, не удалось отправить данные на печать")
XCTAssertNotNil(expectedResult, "Полученный результат не должен быть nil")
```

```swift
// ❌ Не принимается

XCTAssertEqual(success, true, "Ошибка, не удалось отправить данные на печать")
XCTAssertNotEqual(expectedResult, nil, "Полученный результат не должен быть nil")
XCTAssert(success != nil)
```

**Примечания:**
- при написании тестов не используются пустые методы;
- модульные тесты, помеченные как `private`, автоматически пропускаются;