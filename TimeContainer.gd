extends VFlowContainer

var time_item
var date_item

var frame = 0
var time = 1
var day = 1

func _ready():
	time_item = ControlUtil.create_resource_item(self, "time_sprite", func():return str(time))
	
	date_item = ControlUtil.create_resource_item(self, "date_sprite", func():return str(day))
	update()

func update():
	time_item.update()
	date_item.update()

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
