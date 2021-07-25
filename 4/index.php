<?php
	session_start();
	if (!isset($_SESSION['text'])) {
		$text = file_get_contents('templates/text.tpl');
	} else {
		$text = $_SESSION['text'];
		$_SESSION['text'] = null;
	}

	if (isset($_POST['send'])) {
		$string = $_POST['string'];
		$string = strip_tags($string);

		//парсим строку для получения массива слов или словосочетаний в двойных кавычках
		$userString = str_getcsv($string, " ");

		$match = [];
		
		foreach ($userString as $value) {
			//если пользователь ввёл не слово, а другие символы, пропускаем это значение из массива
			if (preg_match('/^[a-zа-я\s]+$/iu', $value)) {
				//ищем совпадения каждого значения с базовым шаблоном по регулярному выражению без учёта регистра (флаг i) и получаем массив совпадений $matches. Чтобы можно было работать и с русским и с англ. текстом добавляем (флаг u)
				preg_match_all('/\b(' . $value . ')\b/iu', $text, $matches);
				
				//так как слов в поиске может быть несколько, добавляем все совпадения по каждому слову в массив $match
				foreach ($matches[0] as $elem) {
					$match[] = $elem;
				}		
			}	
		}
		
		//если совпадения есть - массив не пустой
		if (count($match)) {
			foreach ($match as $value) {
				//формируем новое значение для замены в шаблоне и помещаем в массив замен. Чтобы после замены слов в шаблоне на подсвеченные сохранился регистр букв, берём значения $value, полученные ранее из базового шаблона - массив $match, а не из строки поиска
				$newValue = '<span>' . $value . '</span>';
				$replacement[] = $newValue;

				//формируем регулярные выражения для замен и добавляем в массив $pattern  
				$value = '/\b(' . $value . ')\b/u';
				$pattern[] = $value;
			}

			$text = preg_replace($pattern, $replacement, $text);			
			$_SESSION['text'] = $text;
		}
		
		header('Location: index.php');
				
	}	
?>

<!DOCTYPE html>
<html lang="zxx">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="styles/style.css" rel="stylesheet">
	<title>Finder</title>
</head>
<body>
	<h1>Найти строку в тексте</h1>
	<div class="form"> 
		<form action="index.php" method="post">	
			<p><label>Ключевая строка:<input type="text" name="string" required></label></p>
						
			<input class="find" name="send" type="submit" value="Поиск">			
			<hr>
		</form>
	</div>
	<div class="text">
		<?php
			echo $text;
		?>
	</div>
</body>
</html>