extends "res://Card.gd"

var Topic

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Init(inTopic=null):
	Topic = inTopic
	Name = "Surface {0}".format([Topic])
	Description = "Surface the topic of [{0}], unifying those with same orientations, and dividing those without".format([Topic])
	SetText(Name)

func OnMouseEnter():
	# color Persons based on topic/orientation
	var Persons = get_tree().get_nodes_in_group("Persons")
	for Person in Persons:
		var OrientationIdx = Tools.Topics[Topic]['Orientations'].keys().find(Person.Opinions[Topic])
		Person.SetColor(Tools.Colors[OrientationIdx])
	# draw and color relations
	get_tree().get_root().get_node("Main").DrawRelations(true)
	for i in range(len(Persons)):
		for j in range(i+1, len(Persons)):
			var curLine = Line.instance()
			get_tree().get_root().get_node("Main").add_child(curLine)
			var lineColor = Color(Tools.minGrey,Tools.minGrey,Tools.minGrey,1.0)
			if (Persons[i]['Opinions'][Topic] == Persons[j]['Opinions'][Topic]):
				lineColor = Tools.ColorPos
			else:
				lineColor = Tools.ColorNeg
			curLine.SetLine(Persons[i], Persons[j], "", lineColor)
	get_tree().get_root().get_node("Main").SetInfoText(Description)
	
func Activate():
	var Persons = get_tree().get_nodes_in_group("Persons")
	for i in range(len(Persons)):
		for j in range(i+1, len(Persons)):
			var Value = -1
			if (Persons[i]['Opinions'][Topic]==Persons[j]['Opinions'][Topic]):
				Value = 1
			Persons[i].AddRelation(Persons[j], Name, Name, Value) # do I really need name vs. description
			Persons[j].AddRelation(Persons[i], Name, Name, Value)
	Resolve()

