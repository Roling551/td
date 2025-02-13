extends VFlowContainer

var date_item

var turn = 0

func _ready():
	date_item = ControlUtil.create_resource_item(self, "date_sprite", func():return str(turn))
	update()

func update():
	date_item.update()

func proceed_turn():
	turn += 1
	update()
