var pages = [
	'<p>Имя:</p><input type="text" placeholder="Ваше имя">',
	'<p>Фамилия:</p><input type="text" placeholder="Ваша фамилия">',
	'<p>Почта:</p><input type="email" placeholder="Ваш E-mail">'
];

var pattern = [
	/^[a-zа-я]+$/i,
	/^[a-z0-9.-]+\@[a-z]+[.][a-z]{2,}$/i
]

var i = 0;

var form = document.getElementById('form');
var forward = document.getElementById('forward');
var back = document.getElementById('back');

form.innerHTML = pages[0];
forward.onclick = f;
back.onclick = b;

function f() {
	if (checkForm()) {
		i++;

		if (i == (pages.length - 1)) {
			forward.value = 'Завершить';
		}
		
		form.innerHTML = '';
		form.innerHTML = pages[i];
		back.classList.remove('hidden');

		if (i == pages.length) {
			back.classList.toggle('hidden');
			forward.classList.toggle('hidden');
			form.innerHTML = '<p>Спасибо!</p>';
		}
	} else {
		alert('Заполните поле в правильном формате!');
	}
}

function b() {
	i--;

	form.innerHTML = '';
	form.innerHTML = pages[i];

	if (i < (pages.length - 1)) {
		forward.value = 'Далее';
	}
	
	if (i == 0) {
		back.classList.add('hidden');
	}
}

function checkForm() {
	var elem = document.querySelector('input');
	var text = elem.value;

	if (elem.getAttribute('type') == 'email') {
		var result = pattern[1].test(text);
	} else {
		var result = pattern[0].test(text);
	}
	
	return result;
}