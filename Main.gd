extends Node2D
export (PackedScene) var Person
export (PackedScene) var Card
export (PackedScene) var CardOrientation
export (PackedScene) var CardSurface
export (PackedScene) var Line



# Called when the node enters the scene tree for the first time.
func _ready():
	CreatePersons()
	CreateCards()
	DrawRelations()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func CreatePersons():
	var center = Vector2(get_viewport().size.x/2.0, 300)
	var radius = 150
	var numPersons = 5
	for i in range(numPersons):
		var person = Person.instance()
		add_child(person)
		person.position = Vector2(center.x + radius * sin(i * 2 * PI / numPersons), center.y -  radius * cos(i * 2 * PI / numPersons))
	var Persons = get_tree().get_nodes_in_group("Persons")
	for person in Persons:
		person.Init()
			
func CreateCards():
	var numCards = 5
	var xDelta = 50
	var xMid = get_viewport().size.x/2.0
	var y = get_viewport().size.y - 100
	
	var CardTypes = {
		CardOrientation:{'Weight':1},
		CardSurface:{'Weight':1},
	}
	for i in range(numCards):
		var curCardType = Tools.Choice(CardTypes)
		var card = curCardType.instance()
		add_child(card)
				
		if curCardType==CardOrientation:
			var inTopic = Tools.Choice(Tools.Topics)
			var inOrientation  = Tools.Choice(Tools.Topics[inTopic]['Orientations'])
			var inValue = Tools.Choice({
				1:{'Weight':1.0},
				-1:{'Weight':1.0},
				})
			card.Init(inTopic, inOrientation, inValue)
			
		elif curCardType==CardSurface:
			var inTopic = Tools.Choice(Tools.Topics)
			card.Init(inTopic)
		
		
		
		card.SetFixedPosition(Vector2(xMid - (numCards-1) * xDelta + i * xDelta  * 2, y))





func DrawRelations(undo = false, person = null):
	for curLine in get_tree().get_nodes_in_group("Lines"):
		curLine.queue_free()
	if not undo:
		var Persons = get_tree().get_nodes_in_group("Persons")
		for i in range(len(Persons)):
			for j in range(i+1, len(Persons)):
				
				if (person == null) or (Persons[i]==person) or (Persons[j]==person):
					
					var curLine = Line.instance()
					add_child(curLine)
					curLine.SetLine(Persons[i], 
						Persons[j], 
						'{0} ({1})'.format([Persons[i].Relation[Persons[j]]['Value'], Persons[i].Relation[Persons[j]]['Lock']]), 
						Tools.Color(Persons[i].Relation[Persons[j]]['Value'], 
						Tools.MAXABSRELATION))
				
func SetInfoText(text):
	$Info.text = text
