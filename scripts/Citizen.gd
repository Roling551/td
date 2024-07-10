extends Node
class_name Citizen

var needs = {
	"restness": 1.0,
	"satiety": 1.0
}

func want_to_work():
	return needs["restness"] > 0.5 && needs["satiety"] > 0.5

func work(intensity):
	needs["restness"] = clamp(needs["restness"]-intensity*0.1/GlobalConst.frame_per_hour, 0.0, 1.0)
	needs["satiety"] = clamp(needs["satiety"]-intensity*0.02/GlobalConst.frame_per_hour, 0.0, 1.0)

func rest(quality):
	needs["restness"] = clamp(needs["restness"]+quality*0.1/GlobalConst.frame_per_hour, 0.0, 1.0)

func feed(food_amount):
	needs["satiety"] = clamp(needs["satiety"]+food_amount, 0.0, 1.0)

func action():
	needs["satiety"] = clamp(needs["satiety"]-0.04/GlobalConst.frame_per_hour, 0.0, 1.0)
