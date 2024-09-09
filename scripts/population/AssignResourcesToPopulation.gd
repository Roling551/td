extends Node
class_name AssignResourcesToPopulation

static func basic_assign(population_container: PopulationContainer, resources_container: ResourcesContainer):
	var food = resources_container.get_resource("food")
	
	food = Util.divide_resource_proportianlly_to_request(
		food,
		population_container.working_population,
		func(citizen):
			return max(0, 0.9 - citizen.needs["satiety"]),
		func(citizen, amount):
			citizen.feed(amount)
	)
	food = Util.divide_resource_proportianlly_to_request(
		food,
		population_container.population,
		func(citizen):
			return max(0, 0.5 - citizen.needs["satiety"]),
		func(citizen, amount):
			citizen.feed(amount)
	)
	resources_container.resources["food"] = food
