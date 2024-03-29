﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий


Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка = Истина Тогда
		Возврат;
	КонецЕсли;
	
	СуммаДокументаПлан = Расходы.Итог("СуммаПлан");
	СуммаДокументаФакт = Расходы.Итог("СуммаФакт");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	РасходованиеДенежныхСредств.Дата КАК Дата,
	|	РасходованиеДенежныхСредств.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	СУММА(РасходованиеДенежныхСредств.СуммаПлан) КАК СуммаПлан,
	|	СУММА(РасходованиеДенежныхСредств.СуммаФакт) КАК СуммаФакт,
	|	ВЫРАЗИТЬ(РасходованиеДенежныхСредств.Описание КАК СТРОКА(250)) КАК Описание
	|ПОМЕСТИТЬ ВТ_ДанныеДокумента
	|ИЗ
	|	Документ.РасходованиеДенежныхСредств.Расходы КАК РасходованиеДенежныхСредств
	|ГДЕ
	|	РасходованиеДенежныхСредств.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	РасходованиеДенежныхСредств.Дата,
	|	РасходованиеДенежныхСредств.СтатьяДвиженияДенежныхСредств,
	|	ВЫРАЗИТЬ(РасходованиеДенежныхСредств.Описание КАК СТРОКА(250))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеДокумента.Дата КАК Период,
	|	ВТ_ДанныеДокумента.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	ВТ_ДанныеДокумента.СуммаПлан КАК СуммаРасход,
	|	ВТ_ДанныеДокумента.СуммаФакт КАК СуммаФактРасход,
	|	ВТ_ДанныеДокумента.Описание КАК Описание
	|ИЗ
	|	ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	ДвиженияДляОтражения = РезультатЗапроса.Выгрузить();
	
	Движения.УчетФинансовОбороты.Записывать = Истина;
	Движения.УчетФинансовОбороты.Загрузить(ДвиженияДляОтражения);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ДанныеЗаполнения = Неопределено Тогда
		Дата = ТекущаяДатаСеанса();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
	
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
	
#КонецЕсли
