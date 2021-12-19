extends Area2D

var FirstName
var LastName

var Opinions

var Relation
var RelationLog


# Called when the node enters the scene tree for the first time.
func _ready():
	FirstName = Tools.Choice(Tools.FirstNames)
	LastName = Tools.Choice(Tools.LastNames)
	
	Opinions = {}
	for Topic in Tools.Topics:
		Opinions[Topic] = Tools.Choice(Tools.Topics[Topic]['Orientations'])
	
	SetText("{FN} {LN}".format({"FN":FirstName, "LN":LastName}))
	Relation={} # dict(person, dict of value & lock)
	RelationLog={} # dict(person, list of impressions)

func Init():
	var Persons = get_tree().get_nodes_in_group("Persons")
	for curPerson in Persons:
		if curPerson!=self:
			if not curPerson in Relation:
				Relation[curPerson] = {'Value':0, 'Lock':0}
				RelationLog[curPerson] = []

func SetText(text):
	$Sprite/Label.text = text
func SetColor(color):
	$Sprite.modulate = color

func AddRelation(person, name, description, value):
	RelationLog[person].append({'Name':name, 'Description':description, 'Value':value})
	# value must be 1 or -1
	if (Relation[person]['Value'] == Tools.MAXABSRELATION) and (value>0):
		# already at maxabsrelation, not incrementing
		pass
	elif (Relation[person]['Value'] == -Tools.MAXABSRELATION) and (value<0):
		# already at minabsrelation, not decrementing
		pass
	elif (Relation[person]['Lock']!=Tools.RELATIONLOCK):
		# if not locked, in/de-crement
		Relation[person]['Value'] += value
		Relation[person]['Lock'] = 0
		# if we just got to maxabsrelation, start at -1 (so tick relation sets us at 0, not 1)
		if abs(Relation[person]['Value'])==Tools.MAXABSRELATION:
			Relation[person]['Lock'] = -1
	else:
		# locked
		pass

func TickRelationLock():
	for person in Relation:
		if abs(Relation[person]['Lock'])==Tools.RELATIONLOCK:
			# already locked, dont increment
			pass
		elif abs(Relation[person]['Value'])==Tools.MAXABSRELATION:
			# else, if value at max, then increment lock
			Relation[person]['Lock'] += 1
	
	
func OnMouseEnter():
	get_tree().get_root().get_node("Main").DrawRelations(false, self)
	
	# set info text
	var infotext = _to_string()
	infotext+='\nOpinions:'
	for topic in Opinions:
		infotext+= "\n    {0}: {1}".format([topic, Opinions[topic]])
	infotext+='\nRelations:'
	for person in Relation:
		infotext += "\n    {0}: {1}".format([person, Relation[person]['Value']])
	get_tree().get_root().get_node("Main").SetInfoText(infotext)
	
func OnMouseExit():
	get_tree().get_root().get_node("Main").DrawRelations(false)
	get_tree().get_root().get_node("Main").SetInfoText("")

func _to_string():
	return "{0} {1}".format([FirstName, LastName])
