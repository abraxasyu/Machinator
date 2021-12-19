extends Node

var FirstNames = {
	"Smith":{"Weight":1.0},
	"Johnson":{"Weight":1.0},
	"Williams":{"Weight":1.0},
	"Brown":{"Weight":1.0},
	"Jones":{"Weight":1.0},
	"Garcia":{"Weight":1.0},
	"Miller":{"Weight":1.0},
	"Davis":{"Weight":1.0},
	"Rodriguez":{"Weight":1.0},
	"Martinez":{"Weight":1.0},
	"Hernandez":{"Weight":1.0},
	"Lopez":{"Weight":1.0},
	"Gonzalez":{"Weight":1.0},
	"Wilson":{"Weight":1.0},
	"Anderson":{"Weight":1.0},
	"Thomas":{"Weight":1.0},
	"Taylor":{"Weight":1.0},
	"Moore":{"Weight":1.0},
	"Jackson":{"Weight":1.0},
	"Martin":{"Weight":1.0},
	"Lee":{"Weight":1.0},
	"Perez":{"Weight":1.0},
	"Thompson":{"Weight":1.0},
	"White":{"Weight":1.0},
	"Harris":{"Weight":1.0},
	"Sanchez":{"Weight":1.0},
	"Clark":{"Weight":1.0},
	"Ramirez":{"Weight":1.0},
	"Lewis":{"Weight":1.0},
	"Robinson":{"Weight":1.0},
	"Walker":{"Weight":1.0},
	"Young":{"Weight":1.0},
	"Allen":{"Weight":1.0},
	"King":{"Weight":1.0},
	"Wright":{"Weight":1.0},
	"Scott":{"Weight":1.0},
	"Torres":{"Weight":1.0},
	"Nguyen":{"Weight":1.0},
	"Hill":{"Weight":1.0},
	"Flores":{"Weight":1.0},
	"Green":{"Weight":1.0},
	"Adams":{"Weight":1.0},
	"Nelson":{"Weight":1.0},
	"Baker":{"Weight":1.0},
	"Hall":{"Weight":1.0},
	"Rivera":{"Weight":1.0},
	"Campbell":{"Weight":1.0},
	"Mitchell":{"Weight":1.0},
	"Carter":{"Weight":1.0},
	"Roberts":{"Weight":1.0},
}
var LastNames = {
	"Smith":{"Weight":1.0},
	"Johnson":{"Weight":1.0},
	"Williams":{"Weight":1.0},
	"Brown":{"Weight":1.0},
	"Jones":{"Weight":1.0},
	"Garcia":{"Weight":1.0},
	"Miller":{"Weight":1.0},
	"Davis":{"Weight":1.0},
	"Rodriguez":{"Weight":1.0},
	"Martinez":{"Weight":1.0},
	"Hernandez":{"Weight":1.0},
	"Lopez":{"Weight":1.0},
	"Gonzalez":{"Weight":1.0},
	"Wilson":{"Weight":1.0},
	"Anderson":{"Weight":1.0},
	"Thomas":{"Weight":1.0},
	"Taylor":{"Weight":1.0},
	"Moore":{"Weight":1.0},
	"Jackson":{"Weight":1.0},
	"Martin":{"Weight":1.0},
	"Lee":{"Weight":1.0},
	"Perez":{"Weight":1.0},
	"Thompson":{"Weight":1.0},
	"White":{"Weight":1.0},
	"Harris":{"Weight":1.0},
	"Sanchez":{"Weight":1.0},
	"Clark":{"Weight":1.0},
	"Ramirez":{"Weight":1.0},
	"Lewis":{"Weight":1.0},
	"Robinson":{"Weight":1.0},
	"Walker":{"Weight":1.0},
	"Young":{"Weight":1.0},
	"Allen":{"Weight":1.0},
	"King":{"Weight":1.0},
	"Wright":{"Weight":1.0},
	"Scott":{"Weight":1.0},
	"Torres":{"Weight":1.0},
	"Nguyen":{"Weight":1.0},
	"Hill":{"Weight":1.0},
	"Flores":{"Weight":1.0},
	"Green":{"Weight":1.0},
	"Adams":{"Weight":1.0},
	"Nelson":{"Weight":1.0},
	"Baker":{"Weight":1.0},
	"Hall":{"Weight":1.0},
	"Rivera":{"Weight":1.0},
	"Campbell":{"Weight":1.0},
	"Mitchell":{"Weight":1.0},
	"Carter":{"Weight":1.0},
	"Roberts":{"Weight":1.0},
}
# Orientations
var Topics = {
	'Race':{'Weight':1.0, 'Orientations':{
		"Human":{"Weight":1.0},
		"Orc":{"Weight":1.0},
		"Elf":{"Weight":1.0},
	}},
	'Gender':{'Weight':1.0, 'Orientations':{
		"Male":{"Weight":1.0},
		"Female":{"Weight":1.0},
	}},
	'Class':{'Weight':1.0, 'Orientations':{
		"Elite":{"Weight":1.0},
		"Clergy":{"Weight":1.0},
		"Merchant":{"Weight":1.0},
		"Tradesman":{"Weight":1.0},
		"Laborer":{"Weight":1.0},
	}},
	'Fungoid Labor':{'Weight':1.0, 'Orientations':{
		'Pro':{'Weight':1.0},'Anti':{'Weight':1.0},
	}},
	'Conjured Companionship':{'Weight':1.0, 'Orientations':{
		'Pro':{'Weight':1.0},'Anti':{'Weight':1.0},
	}},
	'Spiritwall Tithe':{'Weight':1.0, 'Orientations':{
		'Pro':{'Weight':1.0},'Anti':{'Weight':1.0},
	}},	
	'Corpomorphology':{'Weight':1.0, 'Orientations':{
		'Pro':{'Weight':1.0},'Anti':{'Weight':1.0},
	}},
	'Racial Essentialism':{'Weight':1.0, 'Orientations':{
		'Pro':{'Weight':1.0},'Anti':{'Weight':1.0},
	}},
}

#https://www.carbondesignsystem.com/data-visualization/color-palettes/
var minGrey = 0.6
var ColorPos = Color(minGrey,1.0,minGrey,1.0)
var ColorNeg = Color(1.0,minGrey,minGrey,1.0)

var Colors = [
	Color(minGrey,minGrey,1.0,    1.0),
	Color(1.0,    1.0,    minGrey,1.0),
	Color(minGrey,1.0    ,1.0    ,1.0),
	Color(1.0    ,minGrey,1.0    ,1.0),
	Color(1.0    ,1.0    ,1.0    ,1.0),
]


var RELATIONLOCK = 3
var MAXABSRELATION = 2


static func Choice(input, weight = "Weight"):
	# input must be dict of dict with inner key = weight
	# output is outer key
	var cur = 0
	for i in input:
		cur += input[i][weight]
	var rando = rand_range(0,cur)
	for i in input:
		cur-= input[i][weight]
		if rando >= cur:
			return i

static func Color(Val, maxAbsVal):
	Val = float(Val)
	maxAbsVal = float(maxAbsVal)
	var minGrey = 0.75
	
	var nonmain_max = .75
	var nonmain_min = .25
	var nonmain = nonmain_max - ((abs(Val)-1)/maxAbsVal) * (nonmain_max-nonmain_min) 
	
	if Val>0:
		return Color(nonmain, 1.0, nonmain, 1.0)
	elif Val<0:
		return Color(1.0, nonmain, nonmain, 1.0)
	else:
		return Color(minGrey, minGrey, minGrey, 1.0)

func _ready():
	
	randomize()
