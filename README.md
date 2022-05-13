# TestTaskWaadsu
# Описание
Тестовое задание:

Передать запрос серверу на получение координат (https://waadsu.com/api/russia.geo.json ).
Данные в формате GeoJSON.

Получить список GPS координат от сервера и отрисовать на карте в виде контура по внешним границам России (внутренние контуры областей считать и отрисовывать не надо).  

Особо обратите внимание на часть России за 180 меридианом (Чукотский полуостров). Он должен быть отрисован цельно с остальной частью России.

Посчитать длину внешних границ России, по этим координатам включая все острова.
И отрисовать ее там же на карте.

При нажатии на какую-либо часть карты России выделить другим цветом регион, где произошло нажатие. - (Не реализовано)

Код должен  соответствовать Clean Architecture, а также принципам разработки KISS и DRY. 

Unit tests с positive и negative testing - обязательны. - (Не реализовано)

# Экраны
![hippo](https://media.giphy.com/media/MGKkUEyqAnijF8mIuK/giphy.gif)

## Установка

У вас должны быть установлены SPM:
* <a href="https://github.com/SnapKit/SnapKit">Snapkit</a>
* <a href="https://github.com/mxcl/PromiseKit">PromiseKit</a>

# Детали реализации
## Deployment Target
iOS 13
## Архитектура приложения
**Clean Swift + Coordinator + micro DI + Services (URLSession PromiseKit version)**<br>
## UI
**UIKit without Storyboard and Xibs, only layout with code**<br>
