extends Node
class_name Citizen

var restness = 1.0
var satiety = 1.0

func want_to_work():
	return restness > 0.5 && satiety > 0.5

func work(intensity):
	restness = clamp(restness-intensity*0.1/GlobalConst.frame_per_hour, 0.0, 1.0)
	satiety = clamp(satiety-intensity*0.02/GlobalConst.frame_per_hour, 0.0, 1.0)

func rest(quality):
	restness = clamp(restness+quality*0.1/GlobalConst.frame_per_hour, 0.0, 1.0)

func feed(amount):
	satiety = clamp(satiety+amount, 0.0, 1.0)

func action():
	satiety = clamp(satiety-0.04/GlobalConst.frame_per_hour, 0.0, 1.0)
