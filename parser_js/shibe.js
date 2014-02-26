var BLANK_LINE_CHANCE = 0.5;
var PHRASE_DENSITY = 0.1;
var WOW_DENSITY = 0.05;
var WOW_PHRASES = ['wow', 'amaze','excite'];
var PHRASES_TO_USE = [
'**such [NN]',
'*such [CD]',
'**very [NN]',
'**what [NN]',
'* so much [NN]',
'**much [VB]',
'**much [JJ]',
'**much [JJR]',
'**much [JJS]',
// '*much [NN]',
'*many [NN]',
'*many [MD]',
'**so [JJ]',
'*so [VB]',
'*so [VBD]',
'*so [VBG]',
'*so [VBN]',
'*so [VBP]',
'*so [VBZ]',
];
//var SENTENCE = "This is a test. I hope this works because I will be very mad.";

var lexer = new Lexer();
var posTagger = new POSTagger();
var lexWords = function(sentence){
	var inEl = sentence;
	var words = lexer.lex(inEl);
	return posTagger.tag(words);
};
var objToSortedArray = function(obj){
	//this next part can be optimized
	//right now it is like O(n^2)
	var arr = Array();
	while(Object.keys(obj).length > 0){
		var max = 0;
		var maxVal = null;
		for(var i in obj){
			if(obj[i] > max){
				maxVal = i;
				max = obj[i];
			}
		}
		arr.push(maxVal);
		delete obj[maxVal];
	}
	return arr;
};
var sortWords = function(taggedWords){
	var tags = ['CC', 'CD', 'DT', 'EX', 'FW', 'IN', 'JJ', 'JJR', 'JJS', 'LS', 'MD', 'NN', 'NNP', 'NNPS', 'NNS', 'POS', 'PDT', 'PP$', 'PRP', 'PRP$', 'RB', 'RBR', 'RBS', 'RP', 'SYM', 'TO', 'UH', 'VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ', 'WDT', 'WP', 'WP$', 'WRB'];
	wordList = {};
	for(var t in tags){
		wordList[tags[t]] = {};
	}
	var blacklist = getBlacklist();
	for (var i in taggedWords) {
		var taggedWord = taggedWords[i];
		var word = taggedWord[0].toLowerCase();
		var tag = taggedWord[1];
		word = word.replace(/[^A-Za-z]/g, '');
		if(word.length > 2 && word.indexOf("'") === -1 && blacklist.indexOf(word) === -1){
			if(wordList[tag][word]){
				wordList[tag][word] += 1;
			} else{
				wordList[tag][word] = 1;
			}
		}
	}
	return wordList;
};
var getPhrases = function(){
	var phrases = PHRASES_TO_USE;
	var i = phrases.length;
	for(var k = 0; k < i; k++){
		while(phrases[k][0] === '*'){
			phrases.push(phrases[k].replace(/\*/g, ''));
			phrases[k] = phrases[k].substring(1);
		}
	}
	phrases = phrases.map(function(a){return a.trim().toLowerCase()});
	phrases = phrases.filter(function(a){return a.length > 2});
	return phrases;
};
var getBlacklist = function(){
	var blacklist = ["such,very"];
	blacklist = blacklist.map(function(a){return a.trim().toLowerCase()});
	return blacklist;
};
var getRandomPhrase = function(words, phrases){
	var chosenPhrase = phrases[parseInt(Math.random() * phrases.length)];
	chosenPhrase = chosenPhrase.replace(/\[(.*)\]/g, function(match){
		match = match.replace(/[\[\]]/g, '').toUpperCase();
		if(words[match]){
			var tagwords = Object.keys(words[match]);
			return tagwords[parseInt(Math.random() * tagwords.length)];
		} else{
			return match;
		}
	});
	return chosenPhrase;
};
var createShibe = function(words, phrases){
	outEl = "";

	wow = WOW_DENSITY;
	phraseDensity = PHRASE_DENSITY;
	blankChance = BLANK_LINE_CHANCE;
/**
	for(var line = 0; line < 5; line++){
		if(Math.random() < blankChance){
			//blank line
			outEl += "    \n";
		} else{
			var len = 4;
			outEl += "    ";
			while(len < 5){
				var rand = Math.random();
				var toWrite = "";
				if(rand < phraseDensity){
					toWrite = getRandomPhrase(words, phrases);
				} else if(rand < wow + phraseDensity){
					toWrite = "wow"
				}
				if(len + toWrite.length < 5){
					outEl += toWrite;
					len += toWrite.length;
				}
				var spaces = parseInt(Math.random() * 10) + 5;
				for(var f = 0; f < spaces; f++){
					outEl += " "
				}
				len += spaces;
			}
			outEl += "\n";
		}
	}**/
	var out = "";
	var temp = "";
	var countControl = 0;
	var used_words = [];
	for(var line = 0; line < 5; line++){
		temp = getRandomPhrase(words, phrases) + "\n";
		if ((!temp.match(/undefined/)) && used_words.indexOf(temp) == -1){
			used_words.push(temp);
			out += temp;
		} else {
			line--;
		}
		countControl++;
		if( countControl > 20){
			line += 6;
			out = "Such need\nVery more\nSo words\nMuch to process\n";
		}
	}

	var random_num_wow = Math.random()*WOW_PHRASES.length;
	for(var line = 0; line < random_num_wow; line++){
		out += WOW_PHRASES[Math.floor(Math.random()*WOW_PHRASES.length)] + "\n";
	}

	return out;
};
