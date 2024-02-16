extends CharacterBody2D


const up = Vector2(0,-1)
const flap = 200
const maxfallspeed = 200
const gravity = 10

var motion = Vector2()
var wall = preload("res://wall_node.tscn")
var score =0

func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	velocity.y+=gravity
	if velocity.y > maxfallspeed:
		velocity.y = maxfallspeed
		
	if Input.is_action_just_pressed("Flap"):
		velocity.y= -flap
	move_and_slide()
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)


func Wall_reset():
	var wall_instance = wall.instantiate()
	wall_instance.position = Vector2(100,randi_range(-100,100))
	get_parent().call_deferred("add_child",wall_instance)
	

func _on_resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_detect_area_entered(area):
	if area.name == "Area2D":
		score+=1


func _on_detect_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()
