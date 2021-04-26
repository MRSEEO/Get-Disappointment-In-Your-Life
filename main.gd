extends Control

var list = {
	"name" : ["asd", "asss", "asdasd"],
	"series" : [20, 23, 5],
	"duration" : [10, 5, 1],
	"one_anime" : [],
}

var series = 0
var full_time = 0

func _ready():
	
	#MAIN
	#Число, сколько имён.
	for a in list.name.size():
		$scroll/lists/c_names/names.add_item(str(list.name[a]))
		$scroll/lists/c_series/series.add_item(str(list.series[a]))
		$scroll/lists/c_duration/duration.add_item(str(list.duration[a]))
		
		###Считаем время одного аниме.
		list.one_anime.append(stepify(list.series[a] * list.duration[a] / 60, 0.1)) #Округляем.
		
		$scroll/lists/c_full_anime/full_anime.add_item(str(list.one_anime[a]))
		
	#/// #Число анимешек.
	$text/animes.set_text(str($scroll/lists/c_names/names.get_item_count()))
	
	#/// #Число серий.
	for a in list.series.size():
		series = list.series[0] + list.series[a]
		$text/series.set_text(str(series))
		
	#/// #Полное время.
	for a in list.one_anime.size():
		full_time = list.one_anime[0] + list.one_anime[a]
		$text/total_hours.set_text(str(full_time))



func _on_add_pressed():
	#Проверка на попытку бегства. Ой... Сломать систему.
	if $text_input/name.get_text() != "" and int($text_input/series.get_text()) != 0 and int($text_input/duration.get_text()) != 0:
		#Добавление к массиву.
		list.name.append($text_input/name.get_text())
		list.series.append(int($text_input/series.get_text()))
		list.duration.append(int($text_input/duration.get_text()))
	
		#Добавление к списку.
		$scroll/lists/c_names/names.add_item(str(list.name.back())); $scroll/lists/help.add_item(str(list.name.back())) #Затычка для скроллинга листа.
		$scroll/lists/c_series/series.add_item(str(list.series.back()))
		$scroll/lists/c_duration/duration.add_item(str(list.duration.back()))
	
		#/// Считаем число анимешек.
		$text/animes.set_text(str($scroll/lists/c_names/names.get_item_count()))
	
		#/// Считаем число серий.
		series += list.series.back()
		$text/series.set_text(str(series))
		
		list.one_anime.push_back(stepify(list.series.back() * list.duration.back() / 60, 0.1)) #Округляем.
		$scroll/lists/c_full_anime/full_anime.add_item(str(list.one_anime.back()))
		
		#/// #Полное время. 
		full_time += list.one_anime.back()
		$text/total_hours.set_text(str(full_time))
	
	else:
		$AcceptDialog.popup()



func _on_del_pressed():
	if $scroll/lists/c_names/names.is_anything_selected() != false:
		
		for a in $scroll/lists/c_names/names.get_selected_items().size():
			var del = $scroll/lists/c_names/names.get_selected_items()
			$scroll/lists/c_names/names.remove_item(del[a]); $scroll/lists/help.remove_item(del[a])
			$scroll/lists/c_series/series.remove_item(del[a])
			$scroll/lists/c_duration/duration.remove_item(del[a])
			$scroll/lists/c_full_anime/full_anime.remove_item(del[a])
	else:
		print("no")
