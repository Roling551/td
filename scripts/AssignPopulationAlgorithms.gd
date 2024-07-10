extends Node
class_name AssignPopulationAlgorithms

static func assign_equally(population, working_population, resting_population, unemployed_population, buildings, city):
	var population_wanting_work = []
	working_population.clear()
	resting_population.clear()
	unemployed_population.clear()
	for citizen in population:
		if citizen.want_to_work():
			population_wanting_work.append(citizen)
		else:
			resting_population.append(citizen)
	
	var needed_workers_num = 0
	city.reset_population()
	for building in buildings:
		if building.building_components.has("population"):
			building.building_components["population"].reset_population()

	Util.divide_list_into_requesters(
		population_wanting_work,
		working_population,
		unemployed_population,
		buildings,
		func(requester): 
			if requester.building_components.has("population"):
				return requester.building_components["population"].max_population
			else:
				return 0,
		func(requester, to_assign):
			if requester.building_components.has("population"):
				requester.building_components["population"].assign_population(to_assign)
	)

	city.assign_population(resting_population)
	city.assign_population(unemployed_population)
