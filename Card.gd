extends Node2D
export (PackedScene) var Line

var pressed = false
var offset = Vector2(0.0,0.0)
var FixedPosition
var Name
var Description
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetText(text):
	$Sprite/Label.text = text

func SetFixedPosition(inFixedPosition):
	self.FixedPosition = inFixedPosition
	self.position = inFixedPosition

func Init():
	assert(false, "This method must be overriden.")

func OnMouseEnter():
	assert(false, "This method must be overriden.")
	

func OnMouseExit():
	# undo all shading/labeling by OnMouseEnter
	get_tree().get_root().get_node("Main").DrawRelations()
	for curPerson in get_tree().get_nodes_in_group("Persons"):
		curPerson.SetColor(Color.white)
	# undo infotext
	get_tree().get_root().get_node("Main").SetInfoText("")
	
func Activate():
	assert(false, "This method must be overriden.")


# if pressed inside collisionbox, set bool and offset
func OnInputEvent(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		pressed = event.pressed
		offset = event.position - self.position
			
# if dragging (mouse could be outside of collisionbox in case of quicky dragging), move self position
func _input(event):
	if event is InputEventMouseMotion:
		if pressed:
			# dragging
			self.position = event.position - offset
	elif (pressed) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (!event.pressed):
		# released
		pressed=false
		self.position = FixedPosition
		Activate()

func Resolve():
	# delete all existing cards
	for card in get_tree().get_nodes_in_group("Cards"):
		card.queue_free()
	# generate new cards
	get_tree().get_root().get_node("Main").CreateCards()
	for person in get_tree().get_nodes_in_group("Persons"):
		person.TickRelationLock()
