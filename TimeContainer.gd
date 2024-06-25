extends VFlowContainer

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")
@onready var time_sprite = preload("res://sprites/resource_sprites/time.png")
@onready var date_sprite = preload("res://sprites/resource_sprites/date.png")

var time_item
var date_item

var frame = 0
var time = 1
var day = 1

func _ready():
	time_item = resource_item_prototype.instantiate()
	add_child(time_item)
	time_item.set_icon(time_sprite)
	
	date_item = resource_item_prototype.instantiate()
	add_child(date_item)
	date_item.set_icon(date_sprite)
	update()

func update():
	time_item.set_text(str(time))
	date_item.set_text(str(day))

func proceed_hour():
	if time % 24 == 0:
		day += 1
		time = 1
	else:
		time += 1
	update()

func proceed_frame():
	frame += 1
	if frame % GlobalConst.frame_per_hour == 0:
		proceed_hour()
		return true
	else:
		return false
