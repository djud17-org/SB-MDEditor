---
created: 2022-10-27T01:49:26 
modified: 2022-10-27T01:49:26

type: zettel
zettelkastenId: 20221027014973
author: "leonovka"
---

# Cheatsheet UI-тесты
#zettelkasten 20221027014973

## Работа с приложением

Запуск приложения -- `XCUIApplication().launch()`

Можно запустить с указанием бандла -- `XCUIApplication(bundleIdentifier: "com.apple.springboard").launch()`

Можно запускать с передачей параметров:

``` swift
let app = XCUIApplication()
app.launchArguments = ["-enableTesting"]
app.launch()
```

Запуск с передачей среды окружения
``` swift
let app = XCUIApplication()
app.launchEnvironment = ["serverIP":"192.168.0.1"]
app.launch()
```

Разработчик может в коде обработать и сделать что требуется, например, отключить анимацию  ```UIView.setAnimationsEnabled(false)```

``` swift
#if DEBUG

if CommandLine.arguments.contains("-enableTesting") {
    configureAppForTesting()
}

if ProcessInfo.processInfo.arguments.contains("-enableTesting") {
    configureAppForTesting()
}

var serverIP = ProcessInfo.processInfo.environment["serverIP"]

#endif
```

## Какие элементы у нас есть:

- `app.alerts.element`
- `app.buttons.element`
- `app.collectionViews.element`
- `app.images.element`
- `app.maps.element`
- `app.navigationBars.element`
- `app.pickers.element`
- `app.progressIndicators.element`
- `app.scrollViews.element`
- `app.segmentedControls.element`
- `app.staticTexts.element`
- `app.switches.element`
- `app.tabBars.element`
- `app.tables.element`
- `app.textFields.element`
- `app.textViews.element`
- `app.webViews.element`

## Доступ и поиск элементов

Если в коде установить ```helpLabel.accessibilityIdentifier = "Help"```, то доступ к элементу получаем через ```app.staticTexts["Help"]```

Если у нас есть массив кнопок, то получить первую можно так: 
```app.buttons.firstMatch``` 
или так: 
```app.buttons.element(boundBy: 0)```, 
а пятую так: 
```app.buttons.element(boundBy: 4)```

Классное расширение для поиска labels по куску текста:
``` swift
extension XCUIElement {
  func labelContains(text: String) -> Bool {
    let predicate = NSPredicate(format: "label CONTAINS %@", text)
    return staticTexts.matching(predicate).firstMatch.exists
  }
}
```

Использовать его можно так:
``` swift
let notificationPermission = "Would Like to Send You Notifications"
  if alert.labelContains(text: notificationPermission) {
    alert.buttons["Allow"].tap()
  }
```

### Работа с таблицей

Для работы с таблицей и её ячейками, например для тапа по ним, нужно подготовить таблицу в коде перед тестами.

Нужно добавить `accessibilityIdentifier` в свой `myTableView` и ячейку следующим образом:

Внутри `viewDidLoad()` или любой другой соответствующей функции контроллера прописать

``` swift
myTableView.accessibilityIdentifier = “myUniqueTableViewIdentifier”
``` 
    
Внутри `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)` настроить ячейку

``` swift
cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
```

После этого вы можете написать следующий код в своем тестовом примере, чтобы получить желаемые результаты:

``` swift
let myTable = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
let cell = myTable.cells.element(matching: .cell, identifier: "myCell_0")
cell.tap()
```

Обратите внимание, что это просто поможет вам найти и нажать на нужную ячейку, вы можете добавить некоторые проверки XCTAssert внутри вашего тестового случая, чтобы сделать его более полезным.

## Взаимодействие с элементами

### Тапы

- `tap()` -- обычный тап;
- `doubleTap()` -- двойной тап;
- `twoFingerTap()` -- тап двумя пальцами;
- `tap(withNumberOfTaps:numberOfTouches:)`  -- настраиваемый тап с указанием количества пальцев `numberOfTouches` и количества касаний `withNumberOfTaps`;
- `press(forDuration:)` -- длинный там с удержанием пальца на forDuration секунд.

### Жесты

Обычные свайпы, которые никак не управляются
- `swipeLeft()`;
- `swipeRight()`;
- `swipeUp()`;
- `swipeDown() `.

Настраиваемые жесты
- `pinch(withScale:velocity:)` -- щипок, который используется для изменения масштаба `withScale` и скорости изменения его `velocity`. Уменьшение масштаба в 50% -- `withScale = .5`, увеличение в 2 раза `withScale = 2`. Для точности `velocity = 0`;
- `rotate(_:withVelocity)` -- поворот на угол указанный в радианах со скоростью withVelocity.

## Обработка системных алертов

Они еще называются UI Interruptions, так как прерывают работы с нашим UI. Что бы с ними работать, нужны обработчики UIInterruptionMonitor.

К примеру добавим такой UIInterruptionMonitor для обработки Local Notifications, у которого есть кнопка Allow

``` swift
addUIInterruptionMonitor(withDescription: "Local Notifications") {
  (alert) -> Bool in
  let notifPermission = "Would Like to Send You Notifications"
  if alert.labelContains(text: notifPermission) {
    alert.buttons["Allow"].tap()
    return true
  }
  return false
}
```

Или добавим UIInterruptionMonitor для обработки Microphone Access, у котороего есть кнопка OK

``` swift
addUIInterruptionMonitor(withDescription: "Microphone Access") {
  (alert) -> Bool in
  let micPermission = "Would Like to Access the Microphone"
  if alert.labelContains(text: micPermission) {
    alert.buttons["OK"].tap()
    return true
  }
  return false
}
```

Мы можем не заморачиваться и не обрабатывать каждое из системных алертов, а просто повесить обработчик типа

``` swift
addUIInterruptionMonitor(withDescription: "System Dialog") {
  (alert) -> Bool in
  let okButton = alert.buttons["OK"]
  if okButton.exists {
    okButton.tap()
  }

  let allowButton = alert.buttons["Allow"]
  if allowButton.exists {
    allowButton.tap()
  }

  return true
}
```

Кстати, если нужно нажать на кнопку НЕ РАЗРЕШАТЬ, то надо использовать
 
``` swift
let notificationPermission = "Would Like to Send You Notifications"
if alert.labelContains(text: notificationPermission) {
  alert.buttons["Don’t Allow"].tap()
}
```

Лучше скопировать ```alert.buttons["Don’t Allow"].tap()```, потому что тут не обычный апостроф ', а ’

Та же ситуация и с кавычками в сообщении с запросом прав.

## Скриншоты

Xcode автоматически делает скриншоты, когда запускает тесты пользовательского интерфейса, и автоматически удаляет их, если тесты пройдут успешно. Но если тесты не пройдут, Xcode сохранит скриншоты, чтобы выяснить, что пошло не так.

Можно сделать снимки экрана вручную, и попросить Xcode сохранить скриншоты даже после прохождения тестов.

У элементов для создания скриншоте есть метод screenshot()

``` swift
let buttonScreenshot = app.button.firstMatch.screenshot()
let mainScreenScreenshot = XCUIScreen.main.screenshot()


 override func tearDown() {
  // Taking screenshot after test
  let screenshot = XCUIScreen.main.screenshot()
  let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
  fullScreenshotAttachment.name = "Fail test"
  fullScreenshotAttachment.lifetime = .keepAlways
  add(fullScreenshotAttachment)
  // Closing the app
  app.terminate()
 }
```

## Паузы и ожидания

В общем случае пользовательский интерфейс и модульные тесты должны выполняться как можно быстрее, чтобы разработчик мог их часто запускать, и его не разочаровывала необходимость запуска медленного набора тестов несколько раз в день. В некоторых случаях существует вероятность того, что приложение получит доступ к API из определенных сетей с ограниченной скоростью интернет-соединения или будет работать с медленным оборудованием.

По этим причинам нужно создавать тесты таким образом, чтобы они не выполняли реальных сетевых запросов. А для ускореня отображения UI стоит отключать анимацию. 

Если нужно просто подождать, давайте подождем. И еще, каждая пауза в тестах увеличит прогон всех тестов, а мы же не хотим гонять тесты по 2-8 часов?

### Пауза

Можно просто поставить все на паузу, например при старте в 10 секунд.

```sleep(10)```

Но стоит понимать, что это просто задержка, которая не гарантирует отработки логики и не имеет таймаута по которому отработает негативный сценарий.

### Ожидание

Иногда нужно подождать какой-то элемент. Для этого у них есть метод waitForExistence:

```
<#yourElement#>.waitForExistence(timeout: 5)
```
Еще есть обратный метод

```
<#yourElement#>.waitForElementToNotExist(timeout: 5)
```

## Assertions

```XCTAssert(app.buttons["Submit"].exists)```

```XCTAssertNil(value)```

```XCTAssertNotNil(app.buttons["Submit"])```

```XCTAssertFalse(value)```

```XCTAssertTrue(value)```

```XCTAssertEqual(_, value)```

```XCTAssertEquals()```
