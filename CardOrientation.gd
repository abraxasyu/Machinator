extends "res://Card.gd"

var Topic
var Orientation
var Value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Init(inTopic=null, inOrientation=null, inValue=null):
	Topic = inTopic
	Orientation = inOrientation
	Value = inValue
	
	var ValueText
	if Value>0:
		ValueText = "Celebrate"
	else:
		ValueText = "Demonize"
		
	Name = "{0} {1} ({2})".format([ValueText, Orientation, Topic])
	Description = "{0} those who have the [{1}] opinion on the topic of [{2}]".format([ValueText, Orientation, Topic])
	SetText(Name)

func OnMouseEnter():
	# color Persons based on topic/orientation
	var Persons = get_tree().get_nodes_in_group("Persons")
	for Person in Persons:
		if Person['Opinions'][Topic]==Orientation:
			if Value>0:
				Person.SetColor(Tools.ColorPos)
			else:
				Person.SetColor(Tools.ColorNeg)
	# draw and color relations
	get_tree().get_root().get_node("Main").DrawRelations(true)
	for i in range(len(Persons)):
		for j in range(i+1, len(Persons)):
			var curLine = Line.instance()
			get_tree().get_root().get_node("Main").add_child(curLine)
			var lineColor = Color(Tools.minGrey,Tools.minGrey,Tools.minGrey,1.0)
			if (Persons[i]['Opinions'][Topic]==Orientation) or (Persons[j]['Opinions'][Topic]==Orientation):
				if Value>0:
					lineColor = Tools.ColorPos
				else:
					lineColor = Tools.ColorNeg
			curLine.SetLine(Persons[i], Persons[j], "", lineColor)
	get_tree().get_root().get_node("Main").SetInfoText(Description)
	
func Activate():
	var Persons = get_tree().get_nodes_in_group("Persons")
	for i in range(len(Persons)):
		for j in range(i+1, len(Persons)):
			if (Persons[i]['Opinions'][Topic]==Orientation) or (Persons[j]['Opinions'][Topic]==Orientation):
				Persons[i].AddRelation(Persons[j], Name, Name, Value) # do I really need name vs. description
				Persons[j].AddRelation(Persons[i], Name, Name, Value)
	Resolve()

