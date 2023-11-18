Map<String, dynamic> vehicleData = {
  'vehicleId': 'vehicleId_1', // Идентификатор техники
  'name' : 'RSM 3535 #7089', // Название техникик
  "createdBy" : {
    'id': 'userId',
    'name': 'lastName',
  }, // Создан тем-то
  "assignedTo": null, // Назначен тому-то
  'createdAt': '11.18.2023 01:00', // Время и дата создания задания,
  'updatedAt': '11.18.2023 01:00', // Время и дата изменения задания
  'operation' : 'Посев', //Операции, которые выполняет техника
  'workingSpeed' : '8-12', //Рабочая скорость техники
  'unit' : {
    'name' : 'Horsh Pronto NT12 #1',
    'depth' : null, // Глубина, см
    'consumptionSolution' : null, //Расход рабочено раствора
  } //Агрегат
};