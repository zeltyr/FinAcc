
&НаСервереБезКонтекста
Процедура ТестоваяИнтеграцияНаСервере()
	
	URLСервиса = "urn:ddengi";
	Прокси = WSСсылки.WSdrebedengi.СоздатьWSПрокси("urn:ddengi", "ddengiService", "SoapPort");
	getAccessStatus = Прокси.getAccessStatus("demo_api", "demo@example.com", "demo");
	getBalanceparam = Новый Массив;
	getBalanceparam.Добавить(
		Новый Структура("restDate", ДАТА(2010,11,29))
	);
	//getBalanceparam = Новый Структура("restDate", ДАТА(2010,11,29));
	
	//Сериализатор = Новый СериализаторXDTO(Прокси.ФабрикаXDTO);
	//getBalanceparam1 = Сериализатор.ЗаписатьXDTO(getBalanceparam);
	ТипСтрока=ФабрикаXDTO.Тип("http://www.w3.org/2001/XMLSchema","string");
	Фабрика=Прокси.ФабрикаXDTO;
	СписокОбъектов = Фабрика.Создать(ФабрикаXDTO.Тип("http://v8.1c.ru/8.1/data/core", "Array"));
	
	//Значение=Фабрика.Создать(ТипСтрока,стр);
	//СписокОбъектов.value.Добавить(Значение);
	
	getBalance = Прокси.getBalance("demo_api", "demo@example.com", "demo", СписокОбъектов);

КонецПроцедуры

&НаКлиенте
Процедура ТестоваяИнтеграция(Команда)
	ТестоваяИнтеграцияНаСервере();
КонецПроцедуры
