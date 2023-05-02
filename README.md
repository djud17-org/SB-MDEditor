# MdEditor

Учебный проект на курсе: [Middle iOS-Developer](https://swiftbook.org/professions/71/show_promo):  Приложение-редактор MD файлов.

Цели приложения:

* Работа с файловой системой iOS;
* Просмотр, создание и редактирование MD файлов;

# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Dependencies](#dependencies)
7. [Workflow](#workflow)
8. [Task board](#task-board)
9. [Design](#design)
10. [Team](#team)

# Description

* Приложение состоит нескольких экранов:
    - Стартовый, отображает:
        - Список недавних документов
        - Меню:
            - Создать документ
            - Открыть документ
            - О приложении
    - Создать документ, возможности:
        - задать имя
        - сохранить в папку документов
    - Открыть документ - реализована навигация по файловой системе. Источником папок должны быть: подшитые к bandle документы и содержимое папки Documents.
    - О приложении: выводить содержимое подключенного файла about.md с описанием приложения и участников команды
* Для навигации используется шаблон Coordinator

[In progress]

Описание функциональных требований формируется на основании домашний заданий.

# Getting started

1. Убедитесь что на компьютере установлен Xcode версии 13 или выше.
2. Загрузите файлы `MdEditor-проекта` из репозитория.
3. Откройте файл проекта в Xcode.
5. Запустите активную схему.

# Usage

[In progress]

# Architecture

* Clean Swift

[In progress]

# Structure

* "App": App и Scene delegates, глобальные объекты приложения: DI, навигация и др.
* "Models": Модели глобальных объектов
* "Modules": Содержит модули приложения (UI + код)
* "Library": Протоколы, расширения и утилиты
* "Resources": Ресурсы приложения: картинки, шрифты и другие типы ресурсов. А также файлы и каталоги: 
    - Theme - содержит файлы со статические методами по поддержке работы с ресурсами приложения и некоторые дополнительные сервисные методы.
    - LaunchScreen.storyboard
    - Info.plist

# Dependencies

[In progress]

# Workflow

* Задачи по ДЗ выполняются в отдельных ветках m3lxHW, где x номер лекции-основания, отводятся от ветки `main` или ветки предыдущего задания, которое еще не влито в `main`
* Фичевые ветки отводятся от веток заданий
* По окончанию работ над фичей создается PR на вливание в ветку соответствующего задания, решаются возможные конфликты и отдается на ревью
* После успешной проверки и получении апрува изменения вливаются в ветку задания через `merge request` (с опцией `squash`) и фичевая ветка удаляется
* По окончанию работ над заданием ветка m3lxHW вливается в `main` через `merge request` (с опцией `squash`), но не удаляется
* **Влитие веток без PR запрещено!**
* Решение конфликтов между фичевой и веткой задания (или веткой задания и `main`) производится локально с помощью команды `rebase` проблемной ветки на актуальную ветку задания (или `main`). 
* **После решения конфликта необходимо проверить сборку проекта!**

## Branches

* `main` - стабильные версии приложения
* `m3lxHW` - ветки по работе с очередным ДЗ
* `M3Lx/<категория задачи>/<номер issue>-<краткое описание(en)>` - ветки по работе над детальными задачами из ДЗ
* `M3Lx/<категория задачи>/<краткое описание(en)>` - ветки по работе над служебными задачами - профилактика, которые не имеют номер issue

### Категории задач

- `feature` - добавление нового функционала
- `bugfix` - исправление выявленной ошибки
- `tech` - техническая задача, может не иметь описательного issue

### Examples

```
M3L1/feature/1-AboutModule
M3L1/feature/2-ColorScheme
M3L1/bugfix/3-AboutModule
M3L1/tech/4-SwiftGen
```

## Requirements for commit

* **В любом коммите проект должен быть собран без ошибок!**
* Названия коммитов должны быть согласно [гайдлайну](https://www.conventionalcommits.org/ru/v1.0.0/)
* Тип коммита должен быть только в нижнием регистре (feat, fix, refactor, docs и т.д.)
* Должен использоваться present tense ("add feature" not "added feature")
* Должен использоваться imperative mood ("move cursor to..." not "moves cursor to...")

### Examples

* `feat:` - это реализованная новая функциональность из технического задания (добавил поддержку зумирования, добавил footer, добавил карточку продукта). Примеры:

```
feat: add basic page layout
feat: implement search box
feat: implement request to youtube API
feat: implement swipe for horizontal list
feat: add additional navigation button
```

* `fix:` - исправил ошибку в ранее реализованной функциональности. Примеры:

```
fix: implement correct loading data from youtube
fix: change layout for video items to fix bugs
fix: relayout header for firefox
fix: adjust social links for mobile
```

* `refactor:` - новой функциональности не добавлял / поведения не менял. Файлы в другие места положил, удалил, добавил. Изменил форматирование кода (white-space, formatting, missing semi-colons, etc). Улучшил алгоритм, без изменения функциональности. Примеры:

```
refactor: change structure of the project
refactor: rename vars for better readability
refactor: apply prettier
```

* `docs:` - используется при работе с документацией/readme проекта. Примеры:

```
docs: update readme with additional information
docs: update description of run() method
```

[Источник](https://docs.rs.school/#/git-convention?id=%d0%9f%d1%80%d0%b8%d0%bc%d0%b5%d1%80%d1%8b-%d0%b8%d0%bc%d0%b5%d0%bd-%d0%ba%d0%be%d0%bc%d0%bc%d0%b8%d1%82%d0%be%d0%b2)

## Tools

В проекте используются:

- [SwiftLint](https://github.com/realm/SwiftLint) - для обеспечения соблюдения стиля и соглашений Swift

```sh
brew update
brew install swiftlint
```

- Live Preview с помощью SwifUI

```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewProvider: PreviewProvider {
	static var previews: some View {
		let viewController = ViewController()
		let labelView = viewController.makeWelcomeLabel() as UIView
		let labelView2 = viewController.makeWelcomeLabel() as UIView
		Group {
			viewController.preview()
			VStack(spacing: 0) {
				labelView.preview().frame(height: 100).padding(.bottom, 20)
				labelView2.preview().frame(height: 100).padding(.bottom, 20)
			}
		}
	}
}
#endif
```

# Task board

* Доска задач в виде проекта на GitHub
* Задачи описываются в issue и связываются с фичевыми ветками для разработки
* ДЗ описывается в отдельном issue и связывается с веткой m3lxHW

# Design

* Готового дизайна нет 

# Team

1. [Anton Zarichny](https://github.com/zzzarya)
2. [David Tonoyan](https://github.com/djud17)
3. [Dmitriy Churilov](https://github.com/chuRealOff)
4. [Sergei Shliakhin (team lead)](https://github.com/SShliakhin)
