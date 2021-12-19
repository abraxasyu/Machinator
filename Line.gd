extends Line2D

var p1
var p2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func SetLine(person1, person2, text, color):
	p1 = person1
	p2 = person2
	self.clear_points()
	self.add_point(person1.position)
	self.add_point(person2.position)
	
	$Label.text = str(text)
	$Label.rect_global_position = (person1.position + person2.position)/2 - $Label.rect_size/2
	
	self.default_color = color
