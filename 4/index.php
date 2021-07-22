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

		$userString = str_getcsv($string, " ");

		foreach ($userString as $key => $value) {
			$newValue = '<span>' . $value . '</span>';
			$replacement[] = $newValue;

			$value = '/\b(' . $value . ')\b/i';
			$pattern[] = $value;			
		}

		$text = preg_replace($pattern, $replacement, $text);
		$_SESSION['text'] = $text;
		
		header('Location: /');		
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