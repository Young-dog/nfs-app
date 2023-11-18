import 'dart:math';

Map<String, dynamic> landData = {
  'landId': 'landId_1', // Уникальный идентификатор поля
  'title': 'Тридевятое царство', // Название поля
  'square': 200, // Площадь
  'coordinates': const Point(1.0, 1.0), // Координаты

  "createdBy": {
    'id': 'userId',
    'name': 'lastName',
  }, // Создан тем-то

  "createdAt": "2011-04-22T13:33:48Z", // Время и дата создания
  "updatedAt": "2011-04-22T13:33:48Z", // Время и дата обновления
};