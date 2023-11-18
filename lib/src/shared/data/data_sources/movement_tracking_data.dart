import 'dart:math';

Map<String, dynamic> movementTrackingData = {
  'recordId': 'recordId_1', // Идентификатор записи (автоматически генерируется).
  'moduleId': 'moduleId_1', // Идентификатор модуля (связан с таблицей "module_info").
  'coordinates': const Point(1.0, 1.0), // Координаты модуля (тип данных POINT, который может хранить пару координат).
  'moduleVolume': 178, // Объем в модуле на момент записи.
  'solventTypeId': 'solventTypeId_1', // Идентификатор типа раствора в модуле (связан с таблицей "solvent_types").
  'registrationTime': '11.18.2023 01:00', // Дата и время регистрации на модуле в АСУ ТП.
  'entry_time': '11.18.2023 01:00', // Дата и время поступления записи в систему (по умолчанию - текущая дата и время).
};